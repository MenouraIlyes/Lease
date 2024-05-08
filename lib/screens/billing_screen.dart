import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lease/models/reservation_model.dart';
import 'package:lease/shared/colors.dart';

class BillingScreen extends StatefulWidget {
  final Reservation reservation;

  const BillingScreen({super.key, required this.reservation});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  int _type = 1;

  void _handleRadio(int value) {
    setState(() {
      _type = value;
    });
  }

  double calculateCommission(double totalPrice) {
    return totalPrice * 0.05;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Reservation selectedReservation = widget.reservation;
    double totalPrice = double.parse(selectedReservation.totalPrice);
    double commissionFees = calculateCommission(totalPrice);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Billing Details",
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  _handleRadio(1);
                },
                child: Container(
                  width: size.width,
                  height: 55,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    border: _type == 1
                        ? Border.all(width: 1, color: appBlue)
                        : Border.all(width: 0.3, color: appGrey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _type,
                          onChanged: (Value) {
                            _handleRadio(1);
                          },
                          activeColor: appBlue,
                        ),
                        Text(
                          'Carte Edahabia',
                          style: _type == 1
                              ? GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: appBlack)
                              : GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: appGrey),
                        ),
                        Image.asset(
                          "assets/edahabia.png",
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  _handleRadio(2);
                },
                child: Container(
                  width: size.width,
                  height: 55,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    border: _type == 2
                        ? Border.all(width: 1, color: appBlue)
                        : Border.all(width: 0.3, color: appGrey),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Radio(
                            value: 2,
                            groupValue: _type,
                            onChanged: (Value) {
                              _handleRadio(2);
                            },
                            activeColor: appBlue,
                          ),
                          Text(
                            'Carte CIB',
                            style: _type == 2
                                ? GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: appBlack)
                                : GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: appGrey),
                          ),
                          Image.asset(
                            "assets/Cib.png",
                            width: 55,
                            height: 55,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sub-Total:',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: appBlack,
                    ),
                  ),
                  Text(
                    '${selectedReservation.totalPrice} DA',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: appBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Commission fees (%5):',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: appBlack,
                    ),
                  ),
                  Text(
                    '${commissionFees.toStringAsFixed(0)} DA',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: appBlack,
                    ),
                  ),
                ],
              ),
              Divider(height: 30, color: appGrey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price:',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: appBlack,
                    ),
                  ),
                  Text(
                    '${totalPrice + commissionFees} DA',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: appRed,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 180),
              Container(
                child: MaterialButton(
                  minWidth: 330,
                  height: 50,
                  onPressed: () {},
                  color: appBlue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: appWhite),
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "Confirm Payment",
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
    );
  }
}
