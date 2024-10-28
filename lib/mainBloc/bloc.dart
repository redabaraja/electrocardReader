import 'package:cardreader/mainBloc/Model.dart';
import 'package:cardreader/mainBloc/event.dart';
import 'package:cardreader/mainBloc/localData.dart';
import 'package:cardreader/mainBloc/state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardLocalData cardData = CardLocalData();
  @override
  // TODO: implement initialState
  CardState get initialState => InitState();

  @override
  Stream<CardState> mapEventToState(CardEvent event) async* {
    if (event is GetCards) {
      yield LoadingState();
      await cardData.openBox();
      print(await cardData.getData());
      List<CardModel> data = await cardData.getData();
      await cardData.cardBox.close();
      yield Cards(data: data);
    } else if (event is Scan) {
      yield LoadingState();
      String scanRes = await scan();
      if (scanRes == '-1') {
        yield ScanResulte(res: false);
      } else {
        List data = scanRes.split(' ');
        print(data);
        var item = {
          "netWorkName": data[0].toString(),
          "type": data[5].toString(),
          "time": data[3].toString(),
          "size": data[4].toString(),
          "username": data[1].toString(),
          "password": data[2].toString()
        };
        await cardData.openBox();
        await cardData.addData(item);
        await cardData.cardBox.close();
        yield ScanResulte(res: true);
      }
      
    }
    else if(event is DeleteCard){
      yield LoadingState();
      await cardData.openBox();
      await cardData.deleteData(event.index);
      List<CardModel>data=await cardData.getData();
      await cardData.cardBox.close();
      yield Cards(data: data);
    }
  }

  Future scan() async {
    String barcodeScanRes = '';
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff4536", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = "failed";
    }
    return barcodeScanRes;
  }
}
