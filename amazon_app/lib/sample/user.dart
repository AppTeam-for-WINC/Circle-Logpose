import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

// This doesn't exist yet...! See "Next Steps"
part 'user.g.dart';

/// A custom JsonSerializable annotation that supports decoding objects such
/// as Timestamps and DateTimes.
/// This variable can be reused between different models
/// 詳しくは、　https://www.notion.so/json_serializable-d6881f5291fe4df0b5d587d9648b685a?pvs=4
const firestoreSerializable = JsonSerializable(
  converters: firestoreJsonConverters,
  // The following values could alternatively be set inside your `build.yaml`
  explicitToJson: true,
  createFieldMap: true,
  createPerFieldToJson: true,
);


//詳しくは、　https://www.notion.so/c746e2a433744ff7b6f6d91161ed8497?pvs=4
@firestoreSerializable
class User {
  //To ensure validators are applied, 
  //the model instance is provided to the generated $assertUser method. 
  //Note the name of this class is generated based on the model name 
  //(For example, 
  //a model named Product with validators would 
  //generate a $assertProduct method).

  
  User({
    required this.name,
    this.sex,
    required this.age,
    required this.email,
    this.count,
  }) {
    // Apply the validator.
    _$assertUser(this);
  }

  // User({
  //   required this.name,
  //   this.sex,
  //   required this.age,
  //   required this.email,
  //   this.count,
  // })

  ///name is water.
  final String name;

  /// sex is hello world.
  final String? sex;
  final int age;
  final int? count;

  //Indicate created class name.
  @EmailAddressValidator()
  final String email;
}


// User: model, users: collection name
@Collection<Person>('users')
@firestoreSerializable
class Person {
  Person({
    required this.name,
    this.sex = '',
    required this.age,
    required this.id,
    this.count = 0,
  });

  // By adding this annotation, this property will not be considered as part
  // of the Firestore document, but instead represent the document ID.
  //@Id is Setting document id. And id is must be of type String.
  @Id()
  final String id;

  //There are Fields.
  final String name;
  final String? sex;

  // Apply the `Min` validator
  //@Min() means minimum number. Validates a number is not less than this value.
  @Min(0)
  final int age;

  //@Max Validates a number is not greater than this value.
  @Max(30)
  final int count;
}

//Validator is abstract class. Validator has validate method.
//Min, Max class is extended Validator class.
class EmailAddressValidator implements Validator {

  //create a instance of Custom class.
  const EmailAddressValidator();

  @override
  // value is propety value, propertyName is property.
  void validate(Object? value, String propertyName) {
    // (value is String) is to return bool.
    if (value is String) {
      value.endsWith('@gmail.com');
      //Exceptionを使用することで、処理が中断される。
      throw Exception('Error: Email is not valid.');
    }
  }
}
