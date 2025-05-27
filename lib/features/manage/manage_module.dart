import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/manage.dart';

class ManageModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(MainRoute.root, child: (ctx) => const ManageScreen());
    r.child(ManageRoute.rootUser, child: (ctx) => const ManageUser());
    r.child(ManageRoute.rootmovies, child: (ctx) => const ManageMovie());
    r.child(ManageRoute.rootShowtime, child: (ctx) => const ManageShowtime());
    r.child(ManageRoute.rootHall, child: (ctx) => const ManageHall());
    r.child(ManageRoute.rootBooking, child: (ctx) => const ManageBooking());
    r.child(ManageRoute.rootbookdetail, child: (ctx) => const BookingDetail());
    r.child(ManageRoute.rootcoupon, child: (ctx) => const ManageCoupon());
    r.child(ManageRoute.rootstatistic, child: (ctx) => const ManageStatitics());
    r.child(ManageRoute.rootstmonth, child: (ctx) => const StatisticMonth());
    r.child(ManageRoute.rootstmovie, child: (ctx) => const StatisticMovie());
    r.child(ManageRoute.rootchatlist, child: (ctx) => const ChatUserList());
    r.child(ManageRoute.rootchat, child: (ctx) => const ChatPage());
    r.child(ManageRoute.rootgenres, child: (ctx) => const ManageGenres());
  }
}
