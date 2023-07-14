class MyUser {
  String? recordID;
  String? name;
  String? currentlyPregnant;
  String? comorbidities;
  String? periodFirstDay;
  String? daysinCycle;
  String? height;
  String? weight;
  String? age;
  String? activity;
  String? email;
  Null password;

  MyUser(
      {this.recordID,
      this.name,
      this.currentlyPregnant,
      this.comorbidities,
      this.periodFirstDay,
      this.daysinCycle,
      this.height,
      this.weight,
      this.age,
      this.activity,
      this.email,
      this.password});

  MyUser.fromJson(Map<String, dynamic> json) {
    recordID = json['RecordID'];
    name = json['Name'];
    currentlyPregnant = json['CurrentlyPregnant'];
    comorbidities = json['Comorbidities'];
    periodFirstDay = json['PeriodFirstDay'];
    daysinCycle = json['DaysinCycle'];
    height = json['Height'];
    weight = json['Weight'];
    age = json['Age'];
    activity = json['Activity'];
    email = json['Email'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RecordID'] = this.recordID;
    data['Name'] = this.name;
    data['CurrentlyPregnant'] = this.currentlyPregnant;
    data['Comorbidities'] = this.comorbidities;
    data['PeriodFirstDay'] = this.periodFirstDay;
    data['DaysinCycle'] = this.daysinCycle;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['Age'] = this.age;
    data['Activity'] = this.activity;
    data['Email'] = this.email;
    data['Password'] = this.password;
    return data;
  }
}
