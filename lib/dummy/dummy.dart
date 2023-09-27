import 'package:flutter/material.dart';

const dummyData = [
  {"news": "A massive earthquake has struck the city.", "type": "Ambulance"},
  {"news": "A wildfire is spreading rapidly in the forest.", "type": "Fire"},
  {"news": "There's a riot happening in the downtown area.", "type": "Police"},
  {
    "news": "A building has collapsed, and people are trapped inside.",
    "type": "Ambulance"
  },
  {
    "news": "A chemical spill has occurred at the industrial site.",
    "type": "Fire"
  },
  {
    "news":
        "A protest has turned violent, and there's a need for law enforcement.",
    "type": "Police"
  },
  {"news": "A flood has submerged several neighborhoods.", "type": "Ambulance"},
  {
    "news": "A major fire has broken out in a residential area.",
    "type": "Fire"
  },
  {"news": "A hostage situation is ongoing at a bank.", "type": "Police"},
  {
    "news":
        "An accident on the highway requires both ambulance and fire assistance.",
    "type": "Ambulance/Fire"
  },
  {
    "news":
        "A massive fire has erupted at an industrial facility, needing fire and police response.",
    "type": "Fire/Police"
  },
  {
    "news": "A severe car crash demands ambulance and police services.",
    "type": "Ambulance/Police"
  },
  {
    "news":
        "A natural disaster has struck, requiring all three types of assistance.",
    "type": "Ambulance/Fire/Police"
  }
];


List<Map<String, dynamic>> filterChoices = [

  {
    'label': 'Ambulance',
    'icon': Icons.medical_services,
    'category': 'Ambulance'
  },
  {'label': 'Police', 'icon': Icons.shield, 'category': 'Police'},
  {'label': 'Fire Dept', 'icon': Icons.fire_truck, 'category': 'Fire'},
];

List<Map<String, String>> calamityImage = [
  {'Ambulance': 'assets/a.png'},
  {'Fire': 'assets/f.png'},
  {'Police': 'assets/p.png'},
  {'Ambulance/Police': 'assets/a_p.png'},
  {'Fire/Police': 'assets/f_p.png'},
  {'Ambulance/Fire': 'assets/f_a.png'},
  {'Ambulance/Fire/Police': 'assets/all.png'},
];