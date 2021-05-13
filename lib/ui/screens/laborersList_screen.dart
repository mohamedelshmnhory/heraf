import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heraf/providers/auth.dart';
import 'package:heraf/providers/laborers.dart';
import 'package:heraf/services/notification_service.dart';
import 'package:provider/provider.dart';

class LaborersScreen extends StatefulWidget {
  final category;
  const LaborersScreen({Key key, this.category}) : super(key: key);
  @override
  _LaborersScreenState createState() => _LaborersScreenState();
}

class _LaborersScreenState extends State<LaborersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Laborers>(context, listen: false).fetchAndSetLaborers(
          widget.category, Provider.of<Auth>(context, listen: false).token);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final laborersMd = Provider.of<Laborers>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
          centerTitle: true,
        ),
        body: laborersMd.loading
            ? Center(child: CircularProgressIndicator())
            : Directionality(
                textDirection: TextDirection.rtl,
                child: ListView.builder(
                  itemCount: laborersMd.laborers.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: size.height * .15,
                            width: size.width * .35,
                            decoration: BoxDecoration(
                              color: Color(0xff9DDFD3),
                              borderRadius: BorderRadius.circular(29),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      laborersMd.laborers[i].photo),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  laborersMd.laborers[i].name.length > 25
                                      ? '${laborersMd.laborers[i].name.substring(0, 25)}...'
                                      : laborersMd.laborers[i].name,
                                ),
                                Text(
                                  laborersMd.laborers[i].address.length > 25
                                      ? '${laborersMd.laborers[i].address.substring(0, 25)}...'
                                      : laborersMd.laborers[i].address,
                                ),
                                Row(
                                  children: [
                                    Text(laborersMd.laborers[i].rate
                                        .toStringAsFixed(1)),
                                    Icon(
                                      Icons.star,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              NotificationService.sendNotification(
                                  'body',
                                  'title',
                                  Provider.of<Auth>(context, listen: false)
                                      .userDetails
                                      .token);
                            },
                            child: Text("حجز"),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
