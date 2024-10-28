import 'package:cardreader/mainBloc/Model.dart';
import 'package:hive/hive.dart';

class CardLocalData {
  late Box cardBox;

  openBox() async {
    await Hive.openBox("Card");
    cardBox = Hive.box("Card");
  }

  addData(var data) async {
    await cardBox.add(data);
  }

  // addData(var data1) async {
  //   if (cardBox.isEmpty)
  //     await cardBox.put("data", data1);
  //   else {
  //     var data = await cardBox.get("data");
  //     for (var d in data1) {
  //       data.add(d);
  //     }
  //     await cardBox.put("data", data);
  //   }
  // }

  getData() async {
    
    List<CardModel> dataModel = [];
    List data = await cardBox.values.toList();
    for (int i = 0; i < data.length; i++) {
      dataModel.add(CardModel.fromMap(data[i]));
    }
    return dataModel;
  }

  deleteData(int index) async {
    await cardBox.deleteAt(index);
  }

  // getData() async {
  //   List<CardModel> dataModel = [];
  //   var data = await cardBox.get("data");
  //   print(data);
  //   for (int i = 0; i < data.length; i++) {
  //     dataModel.add(CardModel.fromMap(data[i]));
  //   }
  //   return dataModel;
  // }

  checkIsEmpty() {
    return cardBox.isEmpty;
  }
}
