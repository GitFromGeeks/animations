import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String empId;
  final String centerID;
  final String name;
  final String role;
  const Profile(
      {super.key,
      required this.empId,
      required this.centerID,
      required this.name,
      required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 60,
                  child: Text(
                    "A",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: FittedBox(
              child: Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "EmpID : $empId",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const Spacer()
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Roll : $role",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const Spacer()
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Center ID : $centerID",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const Spacer()
            ],
          ),
          const Spacer()
        ],
      ),
    );
  }
}
