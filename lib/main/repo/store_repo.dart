import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:firebase_storage/firebase_storage.dart';

class StoreRepo {
  static uploadFile(String path, String ref) async {
    final storageRef = FirebaseStorage.instance.ref();

    final img.Image? image = await img.decodeImageFile(path);

    if (image == null) {
      return;
    }

    final img.Image resizedImage = img.copyResize(image, width: 300);

    final dir = await Directory.systemTemp.createTemp();

    final resizedPath = '${dir.path}/resized.jpg';

    final File resizedFile = File(resizedPath);
    await resizedFile.writeAsBytes(img.encodeJpg(resizedImage));

    final uploadTask = storageRef.child(ref).putFile(
          resizedFile,
        );

    final snapshot = await uploadTask.whenComplete(() => null);

    return await snapshot.ref.getDownloadURL();
  }
}
