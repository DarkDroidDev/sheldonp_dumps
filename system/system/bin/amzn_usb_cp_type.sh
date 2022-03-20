#!/system/bin/sh
#
# Copyright (C) 2018 Amazon Technologies, Inc. All Rights Reserved
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Description:
# Export the USB charge port type read from sysfs to an Android property
#

TAG="amzn_usb_cp_type: "

mlog() {
    echo $TAG $@ > /dev/kmsg
}

setprop sys.usb.charge_type unknown

hardware=`getprop ro.hardware`

if [ "$hardware" != "mt8695" ] ; then
    mlog "Unknowm hardware type"
    exit;

fi

if [ ! -f /sys/amazon//usb_charge_type ] ; then
    mlog "Cannot get charge type"
    exit;
fi

charge_type=`cat /sys/amazon/usb_charge_type`

# mapping for mt8695
# enum mt65xx_usb_extconn_type {
#	MT_USB_EXTCONN_UNKOWN = 0,
#	MT_USB_EXTCONN_STANDARDHOST = 1,
#	MT_USB_EXTCONN_CHARGINGHOST = 2,
#	MT_USB_EXTCONN_NONSTANDARDCHARGER = 3,
#	MT_USB_EXTCONN_STANDARDCHARGER = 4,
#	MT_USB_EXTCONN_MAXIMUM = 5,
# }

if [ -n "$charge_type" ] ; then

	# validate the value so apps reading the value aren't left to the whims of
	# driver developers...
	case "$charge_type" in
	1)
	charge_type=standard_host
		;;
	2)
	charge_type=charging_host
		;;
	#Amazon 5W is detected as non_standard_charger, so if it passed as non_standard_charger, set the charge_type
	#to wall_charger to avoid low power warning
	3)
	charge_type=wall_charger
		;;
	4)
	charge_type=wall_charger
		;;
	*)
		mlog "Unknown charge type: $charge_type"
		exit
		;;
	esac
	# FOS will NOT send low power warning when knowing wall charger or charging host or
	# empty type is connected, When connecting to Rugen, it's unclear actual source is usb
	# host or wall charger, so we decide not to send warning. In bootloader it should
	# pass as charging host
	mlog "Setting sys.usb.charge_type to " $charge_type
	setprop sys.usb.charge_type $charge_type
fi

