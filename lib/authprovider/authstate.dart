import 'package:appwrite/appwrite.dart';
import 'package:data_visualization/constants/app_constants.dart';
import 'package:data_visualization/model/documentmodel1.dart';
import 'package:data_visualization/model/documentmodel2.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  Client client = Client();
  late Account account;
  late Databases databases;
  RealtimeSubscription? realtimeSubscription;
  Realtime? realtime;
  List<DocModel1>? _item1;
  List<DocModel2>? _item2;
  late bool _isLoading;

  List<DocModel1>? get itemone => _item1;
  List<DocModel2>? get itemtwo => _item2;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _isLoading = false;
    client
        .setEndpoint(Appconstants.endpoint)
        .setProject(Appconstants.projectid);

    account = Account(client);
    databases = Databases(client);
    _initialize();
  }
  void _initialize() async {
    try {
      await account.get();
      _item1 = (await databases.listDocuments(
        databaseId: Appconstants.dbID,
        collectionId: Appconstants.collectionID,
      ))
          .documents
          .map((doc) => DocModel1.fromJson(doc.data))
          .toList();
      _item2 = (await databases.listDocuments(
        databaseId: Appconstants.dbID,
        collectionId: Appconstants.collectionID2,
      ))
          .documents
          .map((doc) => DocModel2.fromJson(doc.data))
          .toList();
      _subscribe();
      _isLoading = true;
      notifyListeners();
    } catch (e) {
      if (e is AppwriteException) {
        await account.createAnonymousSession();
        _initialize();
      }
    }
  }

  void _subscribe() {
    try {
      final realtime = Realtime(client);
      realtimeSubscription = realtime.subscribe([
        'databases.${Appconstants.dbID}.collections.${Appconstants.collectionID}.documents',
        'databases.${Appconstants.dbID}.collections.${Appconstants.collectionID2}.documents'
      ]);
      realtimeSubscription?.stream.listen((event) {
        if (event.events.contains(
            'databases.${Appconstants.dbID}.collections.${Appconstants.collectionID}.documents.*.create')) {
          DocModel1 myDocModel1 = DocModel1.fromJson(event.payload);
          _item1?.add(myDocModel1);
          notifyListeners();
        }
        if (event.events.contains(
            'databases.${Appconstants.dbID}.collections.${Appconstants.collectionID}.documents.*.delete')) {
          _item1?.removeWhere((element) => element.id == event.payload['\$id']);
          notifyListeners();
        }
        if (event.events.contains(
            'databases.${Appconstants.dbID}.collections.${Appconstants.collectionID2}.documents.*.update')) {
          _item2
              ?.map(
                (element) =>
                    element.productnumber = event.payload['productnumber'],
              )
              .toList();
          notifyListeners();
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    realtimeSubscription?.close();
    super.dispose();
  }
}
