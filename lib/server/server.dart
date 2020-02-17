class Server {
  String addressLogin =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiGetLogin.php";
  String addressRegister =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiPushRegister.php";
  String addressListRestaurent =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiGetAllRestaurent.php";
  String addressListFood =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiGetFood.php";
  String billOrder =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiPushBillOrder.php";
  String getLocationMain =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiGetLocationMain.php";
  String updateLocation =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiUpdateLocation.php";

  //----- Driver
  String driverGetOrder =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/api_driver/apiGetOrderDriver.php";
  String receiveFood =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiPushReceiveFood.php";

  //----- TimeLine
  String timeLineOrderDeatil =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiGetMyOrderDetail.php";
  String getAllOrder =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiGetMyOrder.php";
  String timeLineOrderStatus =
      "http://std.csit.sci.tsu.ac.th/592021212/Homework/hew-maii/apiGetTimelineOrder.php";
  Server() : super();
}
