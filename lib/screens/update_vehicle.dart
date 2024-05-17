import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lease/Api_endpoint/services.dart';
import 'package:lease/models/vehicle_model.dart';
import 'package:lease/providers/vehicle_provider.dart';
import 'package:lease/shared/colors.dart';
import 'package:provider/provider.dart';

class UpdateVehicleScreen extends StatefulWidget {
  final Vehicle vehicle;
  const UpdateVehicleScreen({super.key, required this.vehicle});

  @override
  State<UpdateVehicleScreen> createState() => _UpdateVehicleScreenState();
}

class _UpdateVehicleScreenState extends State<UpdateVehicleScreen> {
  List<File> _selectedImages = [];
  List<String> _cloudinaryImages = [];

  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController transmissionController = TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController doorsController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController gasTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController basePriceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _fetchVehicle();
  }

  // Upload images to cloudinary
  Future<List<String>> uploadImages(List<String> imagePaths) async {
    const cloudName = 'dhqgycty6';
    const uploadPreset = 'k8rbqd6s';
    final List<String> uploadedUrls = [];

    final cloudinary = CloudinaryPublic(cloudName, uploadPreset);

    for (final imagePath in imagePaths) {
      final file = File(imagePath);
      try {
        final CloudinaryResponse uploadResponse = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(file.path,
              resourceType: CloudinaryResourceType.Image),
        );
        uploadedUrls.add(uploadResponse.secureUrl);
      } catch (error) {
        print('Error uploading image: $imagePath - $error');
      }
    }

    return uploadedUrls;
  }

  Future<void> _fetchVehicle() async {
    try {
      final vehicle = widget.vehicle;

      // Populate text fields with fetched vehicle data
      if (vehicle != null) {
        setState(() {
          makeController.text = vehicle.make;
          modelController.text = vehicle.model;
          yearController.text = vehicle.year.toString();
          transmissionController.text = vehicle.transmission;
          seatsController.text = vehicle.seats.toString();
          doorsController.text = vehicle.doors.toString();
          mileageController.text = vehicle.mileage;
          gasTypeController.text = vehicle.gasType;
          descriptionController.text = vehicle.description;
          basePriceController.text = vehicle.basePrice;
          _cloudinaryImages = vehicle.photos;
        });
      }
    } catch (error) {
      print('Error fetching vehicle information: $error');
    }
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(
      imageQuality: 70,
      maxWidth: 800,
    );
    if (pickedImages != false) {
      setState(() {
        _selectedImages =
            pickedImages.map((image) => File(image.path)).toList();
      });
    }
  }

  void _updateVehicle() async {
    if (makeController.text.isEmpty ||
        modelController.text.isEmpty ||
        yearController.text.isEmpty ||
        transmissionController.text.isEmpty ||
        seatsController.text.isEmpty ||
        doorsController.text.isEmpty ||
        mileageController.text.isEmpty ||
        gasTypeController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        basePriceController.text.isEmpty ||
        (_selectedImages.isEmpty && _cloudinaryImages.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'All fields are required to fill!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
      return;
    }

    try {
      List<String> uploadedUrls = [];
      if (_selectedImages.isNotEmpty) {
        uploadedUrls = await uploadImages(
            _selectedImages.map((file) => file.path).toList());
      }
      // Check if all images were uploaded successfully
      if (uploadedUrls.length != _selectedImages.length) {
        throw Exception('Failed to upload all images.');
      }
      final Vehicle updatedVehicle = Vehicle(
        make: makeController.text,
        model: modelController.text,
        year: int.tryParse(yearController.text) ?? 0,
        transmission: transmissionController.text,
        seats: int.tryParse(seatsController.text) ?? 0,
        doors: int.tryParse(doorsController.text) ?? 0,
        mileage: mileageController.text,
        gasType: gasTypeController.text,
        description: descriptionController.text,
        basePrice: basePriceController.text,
        photos: uploadedUrls.isNotEmpty ? uploadedUrls : _cloudinaryImages,
      );

      await ApiService.updateVehicle(widget.vehicle.id, updatedVehicle);
      // Close the loading indicator
      Navigator.of(context).pop();

      context.go('/home');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Vehicle updated successfully!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
    } catch (error) {
      print('Error updating: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update your vehicle",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: appWhite,
            boxShadow: [
              BoxShadow(
                color: appBlack.withOpacity(0.1),
                blurRadius: 1.0,
                spreadRadius: 1.0,
                offset: const Offset(0.0, 1.0),
              )
            ],
          ),
        ),
      ),
      backgroundColor: appWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                //image
                Container(
                  height: MediaQuery.of(context).size.height / 6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/car.png'),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 10),
                  child: Text(
                    "Please fill your vehicle informations below !",
                    style: GoogleFonts.poppins(fontSize: 20, color: appBlue),
                  ),
                ),
                SizedBox(height: 20),

                //make textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: makeController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Make (Toyota...etc)',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                //model textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: modelController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Model (Supra...etc)',
                        ),
                      ),
                    ),
                  ),
                ),
                //year textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: yearController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Year',
                        ),
                      ),
                    ),
                  ),
                ),

                //Transmission textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: transmissionController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Transmission (Manual or Automatic)',
                        ),
                      ),
                    ),
                  ),
                ),

                //seats textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: seatsController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Number of seats',
                        ),
                      ),
                    ),
                  ),
                ),

                //doors textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: doorsController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Number of doors',
                        ),
                      ),
                    ),
                  ),
                ),

                //mileage textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: mileageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Mileage',
                        ),
                      ),
                    ),
                  ),
                ),

                //gas type textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: gasTypeController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Gas Type (Diesel...etc)',
                        ),
                      ),
                    ),
                  ),
                ),

                //Description textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Description',
                        ),
                      ),
                    ),
                  ),
                ),

                //base price textfield
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: appWhite),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: basePriceController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Price for a day',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Select Vehicle pics button
                Container(
                  child: MaterialButton(
                    minWidth: 330,
                    height: 50,
                    onPressed: _pickImages,
                    color: appGrey.withAlpha(90),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: appBlack.withAlpha(90)),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Select Images of your vehicle",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: appBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (_selectedImages.isNotEmpty || _cloudinaryImages.isNotEmpty)
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        _selectedImages.length + _cloudinaryImages.length,
                    itemBuilder: (context, index) {
                      if (index < _selectedImages.length) {
                        // Render picked images
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              _selectedImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else {
                        // Render images from Cloudinary
                        final cloudinaryIndex = index - _selectedImages.length;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              _cloudinaryImages[cloudinaryIndex],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                SizedBox(height: 20),
                //vehicle button
                Container(
                  child: MaterialButton(
                    minWidth: 330,
                    height: 50,
                    onPressed: _updateVehicle,
                    color: appBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: appWhite),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "Update Vehicle",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: appWhite,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
