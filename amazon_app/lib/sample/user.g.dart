// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CollectionGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, use_super_parameters, duplicate_ignore
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_internal_member

class _Sentinel {
  const _Sentinel();
}

const _sentinel = _Sentinel();

/// A collection reference object can be used for adding documents,
/// getting document references, and querying for documents
/// (using the methods inherited from Query).
abstract class PersonCollectionReference
    implements
        PersonQuery,
        FirestoreCollectionReference<Person, PersonQuerySnapshot> {
  factory PersonCollectionReference([
    FirebaseFirestore? firestore,
  ]) = _$PersonCollectionReference;

  static Person fromFirestore(
    DocumentSnapshot<Map<String, Object?>> snapshot,
    SnapshotOptions? options,
  ) {
    return _$PersonFromJson({'id': snapshot.id, ...?snapshot.data()});
  }

  static Map<String, Object?> toFirestore(
    Person value,
    SetOptions? options,
  ) {
    return {..._$PersonToJson(value)}..remove('id');
  }

  @override
  CollectionReference<Person> get reference;

  @override
  PersonDocumentReference doc([String? id]);

  /// Add a new document to this collection with the specified data,
  /// assigning it a document ID automatically.
  Future<PersonDocumentReference> add(Person value);
}

class _$PersonCollectionReference extends _$PersonQuery
    implements PersonCollectionReference {
  factory _$PersonCollectionReference([FirebaseFirestore? firestore]) {
    firestore ??= FirebaseFirestore.instance;

    return _$PersonCollectionReference._(
      firestore.collection('users').withConverter(
            fromFirestore: PersonCollectionReference.fromFirestore,
            toFirestore: PersonCollectionReference.toFirestore,
          ),
    );
  }

  _$PersonCollectionReference._(
    CollectionReference<Person> reference,
  ) : super(reference, $referenceWithoutCursor: reference);

  String get path => reference.path;

  @override
  CollectionReference<Person> get reference =>
      super.reference as CollectionReference<Person>;

  @override
  PersonDocumentReference doc([String? id]) {
    assert(
      id == null || id.split('/').length == 1,
      'The document ID cannot be from a different collection',
    );
    return PersonDocumentReference(
      reference.doc(id),
    );
  }

  @override
  Future<PersonDocumentReference> add(Person value) {
    return reference.add(value).then((ref) => PersonDocumentReference(ref));
  }

  @override
  bool operator ==(Object other) {
    return other is _$PersonCollectionReference &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

abstract class PersonDocumentReference
    extends FirestoreDocumentReference<Person, PersonDocumentSnapshot> {
  factory PersonDocumentReference(DocumentReference<Person> reference) =
      _$PersonDocumentReference;

  DocumentReference<Person> get reference;

  /// A reference to the [PersonCollectionReference] containing this document.
  PersonCollectionReference get parent {
    return _$PersonCollectionReference(reference.firestore);
  }

  @override
  Stream<PersonDocumentSnapshot> snapshots();

  @override
  Future<PersonDocumentSnapshot> get([GetOptions? options]);

  @override
  Future<void> delete();

  /// Updates data on the document. Data will be merged with any existing
  /// document data.
  ///
  /// If no document exists yet, the update will fail.
  Future<void> update({
    String name,
    FieldValue nameFieldValue,
    String? sex,
    FieldValue sexFieldValue,
    int age,
    FieldValue ageFieldValue,
    int count,
    FieldValue countFieldValue,
  });

  /// Updates fields in the current document using the transaction API.
  ///
  /// The update will fail if applied to a document that does not exist.
  void transactionUpdate(
    Transaction transaction, {
    String name,
    FieldValue nameFieldValue,
    String? sex,
    FieldValue sexFieldValue,
    int age,
    FieldValue ageFieldValue,
    int count,
    FieldValue countFieldValue,
  });
}

class _$PersonDocumentReference
    extends FirestoreDocumentReference<Person, PersonDocumentSnapshot>
    implements PersonDocumentReference {
  _$PersonDocumentReference(this.reference);

  @override
  final DocumentReference<Person> reference;

  /// A reference to the [PersonCollectionReference] containing this document.
  PersonCollectionReference get parent {
    return _$PersonCollectionReference(reference.firestore);
  }

  @override
  Stream<PersonDocumentSnapshot> snapshots() {
    return reference.snapshots().map(PersonDocumentSnapshot._);
  }

  @override
  Future<PersonDocumentSnapshot> get([GetOptions? options]) {
    return reference.get(options).then(PersonDocumentSnapshot._);
  }

  @override
  Future<PersonDocumentSnapshot> transactionGet(Transaction transaction) {
    return transaction.get(reference).then(PersonDocumentSnapshot._);
  }

  Future<void> update({
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? sex = _sentinel,
    FieldValue? sexFieldValue,
    Object? age = _sentinel,
    FieldValue? ageFieldValue,
    Object? count = _sentinel,
    FieldValue? countFieldValue,
  }) async {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      sex == _sentinel || sexFieldValue == null,
      "Cannot specify both sex and sexFieldValue",
    );
    assert(
      age == _sentinel || ageFieldValue == null,
      "Cannot specify both age and ageFieldValue",
    );
    assert(
      count == _sentinel || countFieldValue == null,
      "Cannot specify both count and countFieldValue",
    );
    final json = {
      if (name != _sentinel)
        _$PersonFieldMap['name']!: _$PersonPerFieldToJson.name(name as String),
      if (nameFieldValue != null) _$PersonFieldMap['name']!: nameFieldValue,
      if (sex != _sentinel)
        _$PersonFieldMap['sex']!: _$PersonPerFieldToJson.sex(sex as String?),
      if (sexFieldValue != null) _$PersonFieldMap['sex']!: sexFieldValue,
      if (age != _sentinel)
        _$PersonFieldMap['age']!: _$PersonPerFieldToJson.age(age as int),
      if (ageFieldValue != null) _$PersonFieldMap['age']!: ageFieldValue,
      if (count != _sentinel)
        _$PersonFieldMap['count']!: _$PersonPerFieldToJson.count(count as int),
      if (countFieldValue != null) _$PersonFieldMap['count']!: countFieldValue,
    };

    return reference.update(json);
  }

  void transactionUpdate(
    Transaction transaction, {
    Object? name = _sentinel,
    FieldValue? nameFieldValue,
    Object? sex = _sentinel,
    FieldValue? sexFieldValue,
    Object? age = _sentinel,
    FieldValue? ageFieldValue,
    Object? count = _sentinel,
    FieldValue? countFieldValue,
  }) {
    assert(
      name == _sentinel || nameFieldValue == null,
      "Cannot specify both name and nameFieldValue",
    );
    assert(
      sex == _sentinel || sexFieldValue == null,
      "Cannot specify both sex and sexFieldValue",
    );
    assert(
      age == _sentinel || ageFieldValue == null,
      "Cannot specify both age and ageFieldValue",
    );
    assert(
      count == _sentinel || countFieldValue == null,
      "Cannot specify both count and countFieldValue",
    );
    final json = {
      if (name != _sentinel)
        _$PersonFieldMap['name']!: _$PersonPerFieldToJson.name(name as String),
      if (nameFieldValue != null) _$PersonFieldMap['name']!: nameFieldValue,
      if (sex != _sentinel)
        _$PersonFieldMap['sex']!: _$PersonPerFieldToJson.sex(sex as String?),
      if (sexFieldValue != null) _$PersonFieldMap['sex']!: sexFieldValue,
      if (age != _sentinel)
        _$PersonFieldMap['age']!: _$PersonPerFieldToJson.age(age as int),
      if (ageFieldValue != null) _$PersonFieldMap['age']!: ageFieldValue,
      if (count != _sentinel)
        _$PersonFieldMap['count']!: _$PersonPerFieldToJson.count(count as int),
      if (countFieldValue != null) _$PersonFieldMap['count']!: countFieldValue,
    };

    transaction.update(reference, json);
  }

  @override
  bool operator ==(Object other) {
    return other is PersonDocumentReference &&
        other.runtimeType == runtimeType &&
        other.parent == parent &&
        other.id == id;
  }

  @override
  int get hashCode => Object.hash(runtimeType, parent, id);
}

abstract class PersonQuery
    implements QueryReference<Person, PersonQuerySnapshot> {
  @override
  PersonQuery limit(int limit);

  @override
  PersonQuery limitToLast(int limit);

  /// Perform an order query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of order queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.orderByFieldPath(
  ///   FieldPath.fromString('title'),
  ///   startAt: 'title',
  /// );
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.orderByTitle(startAt: 'title');
  /// ```
  PersonQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt,
    Object? startAfter,
    Object? endAt,
    Object? endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });

  /// Perform a where query based on a [FieldPath].
  ///
  /// This method is considered unsafe as it does check that the field path
  /// maps to a valid property or that parameters such as [isEqualTo] receive
  /// a value of the correct type.
  ///
  /// If possible, instead use the more explicit variant of where queries:
  ///
  /// **AVOID**:
  /// ```dart
  /// collection.whereFieldPath(FieldPath.fromString('title'), isEqualTo: 'title');
  /// ```
  ///
  /// **PREFER**:
  /// ```dart
  /// collection.whereTitle(isEqualTo: 'title');
  /// ```
  PersonQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo,
    Object? isNotEqualTo,
    Object? isLessThan,
    Object? isLessThanOrEqualTo,
    Object? isGreaterThan,
    Object? isGreaterThanOrEqualTo,
    Object? arrayContains,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  });

  PersonQuery whereDocumentId({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  PersonQuery whereName({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  });
  PersonQuery whereSex({
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  });
  PersonQuery whereAge({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int>? whereIn,
    List<int>? whereNotIn,
  });
  PersonQuery whereCount({
    int? isEqualTo,
    int? isNotEqualTo,
    int? isLessThan,
    int? isLessThanOrEqualTo,
    int? isGreaterThan,
    int? isGreaterThanOrEqualTo,
    bool? isNull,
    List<int>? whereIn,
    List<int>? whereNotIn,
  });

  PersonQuery orderByDocumentId({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });

  PersonQuery orderByName({
    bool descending = false,
    String startAt,
    String startAfter,
    String endAt,
    String endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });

  PersonQuery orderBySex({
    bool descending = false,
    String? startAt,
    String? startAfter,
    String? endAt,
    String? endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });

  PersonQuery orderByAge({
    bool descending = false,
    int startAt,
    int startAfter,
    int endAt,
    int endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });

  PersonQuery orderByCount({
    bool descending = false,
    int startAt,
    int startAfter,
    int endAt,
    int endBefore,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  });
}

class _$PersonQuery extends QueryReference<Person, PersonQuerySnapshot>
    implements PersonQuery {
  _$PersonQuery(
    this._collection, {
    required Query<Person> $referenceWithoutCursor,
    $QueryCursor $queryCursor = const $QueryCursor(),
  }) : super(
          $referenceWithoutCursor: $referenceWithoutCursor,
          $queryCursor: $queryCursor,
        );

  final CollectionReference<Object?> _collection;

  @override
  Stream<PersonQuerySnapshot> snapshots([SnapshotOptions? options]) {
    return reference.snapshots().map(PersonQuerySnapshot._fromQuerySnapshot);
  }

  @override
  Future<PersonQuerySnapshot> get([GetOptions? options]) {
    return reference.get(options).then(PersonQuerySnapshot._fromQuerySnapshot);
  }

  @override
  PersonQuery limit(int limit) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limit(limit),
      $queryCursor: $queryCursor,
    );
  }

  @override
  PersonQuery limitToLast(int limit) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.limitToLast(limit),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery orderByFieldPath(
    FieldPath fieldPath, {
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query =
        $referenceWithoutCursor.orderBy(fieldPath, descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PersonQuery whereFieldPath(
    FieldPath fieldPath, {
    Object? isEqualTo = notSetQueryParam,
    Object? isNotEqualTo = notSetQueryParam,
    Object? isLessThan = notSetQueryParam,
    Object? isLessThanOrEqualTo = notSetQueryParam,
    Object? isGreaterThan = notSetQueryParam,
    Object? isGreaterThanOrEqualTo = notSetQueryParam,
    Object? arrayContains = notSetQueryParam,
    List<Object?>? arrayContainsAny,
    List<Object?>? whereIn,
    List<Object?>? whereNotIn,
    bool? isNull,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        fieldPath,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
        isNull: isNull,
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery whereDocumentId({
    Object? isEqualTo = notSetQueryParam,
    Object? isNotEqualTo = notSetQueryParam,
    Object? isLessThan = notSetQueryParam,
    Object? isLessThanOrEqualTo = notSetQueryParam,
    Object? isGreaterThan = notSetQueryParam,
    Object? isGreaterThanOrEqualTo = notSetQueryParam,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        FieldPath.documentId,
        isEqualTo: isEqualTo,
        isNotEqualTo: isNotEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        isNull: isNull,
        whereIn: whereIn,
        whereNotIn: whereNotIn,
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery whereName({
    Object? isEqualTo = notSetQueryParam,
    Object? isNotEqualTo = notSetQueryParam,
    Object? isLessThan = notSetQueryParam,
    Object? isLessThanOrEqualTo = notSetQueryParam,
    Object? isGreaterThan = notSetQueryParam,
    Object? isGreaterThanOrEqualTo = notSetQueryParam,
    bool? isNull,
    List<String>? whereIn,
    List<String>? whereNotIn,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$PersonFieldMap['name']!,
        isEqualTo: isEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.name(isEqualTo as String)
            : notSetQueryParam,
        isNotEqualTo: isNotEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.name(isNotEqualTo as String)
            : notSetQueryParam,
        isLessThan: isLessThan != notSetQueryParam
            ? _$PersonPerFieldToJson.name(isLessThan as String)
            : notSetQueryParam,
        isLessThanOrEqualTo: isLessThanOrEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.name(isLessThanOrEqualTo as String)
            : notSetQueryParam,
        isGreaterThan: isGreaterThan != notSetQueryParam
            ? _$PersonPerFieldToJson.name(isGreaterThan as String)
            : notSetQueryParam,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.name(isGreaterThanOrEqualTo as String)
            : notSetQueryParam,
        isNull: isNull,
        whereIn: whereIn?.map((e) => _$PersonPerFieldToJson.name(e)),
        whereNotIn: whereNotIn?.map((e) => _$PersonPerFieldToJson.name(e)),
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery whereSex({
    Object? isEqualTo = notSetQueryParam,
    Object? isNotEqualTo = notSetQueryParam,
    Object? isLessThan = notSetQueryParam,
    Object? isLessThanOrEqualTo = notSetQueryParam,
    Object? isGreaterThan = notSetQueryParam,
    Object? isGreaterThanOrEqualTo = notSetQueryParam,
    bool? isNull,
    List<String?>? whereIn,
    List<String?>? whereNotIn,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$PersonFieldMap['sex']!,
        isEqualTo: isEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.sex(isEqualTo as String?)
            : notSetQueryParam,
        isNotEqualTo: isNotEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.sex(isNotEqualTo as String?)
            : notSetQueryParam,
        isLessThan: isLessThan != notSetQueryParam
            ? _$PersonPerFieldToJson.sex(isLessThan as String?)
            : notSetQueryParam,
        isLessThanOrEqualTo: isLessThanOrEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.sex(isLessThanOrEqualTo as String?)
            : notSetQueryParam,
        isGreaterThan: isGreaterThan != notSetQueryParam
            ? _$PersonPerFieldToJson.sex(isGreaterThan as String?)
            : notSetQueryParam,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.sex(isGreaterThanOrEqualTo as String?)
            : notSetQueryParam,
        isNull: isNull,
        whereIn: whereIn?.map((e) => _$PersonPerFieldToJson.sex(e)),
        whereNotIn: whereNotIn?.map((e) => _$PersonPerFieldToJson.sex(e)),
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery whereAge({
    Object? isEqualTo = notSetQueryParam,
    Object? isNotEqualTo = notSetQueryParam,
    Object? isLessThan = notSetQueryParam,
    Object? isLessThanOrEqualTo = notSetQueryParam,
    Object? isGreaterThan = notSetQueryParam,
    Object? isGreaterThanOrEqualTo = notSetQueryParam,
    bool? isNull,
    List<int>? whereIn,
    List<int>? whereNotIn,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$PersonFieldMap['age']!,
        isEqualTo: isEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.age(isEqualTo as int)
            : notSetQueryParam,
        isNotEqualTo: isNotEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.age(isNotEqualTo as int)
            : notSetQueryParam,
        isLessThan: isLessThan != notSetQueryParam
            ? _$PersonPerFieldToJson.age(isLessThan as int)
            : notSetQueryParam,
        isLessThanOrEqualTo: isLessThanOrEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.age(isLessThanOrEqualTo as int)
            : notSetQueryParam,
        isGreaterThan: isGreaterThan != notSetQueryParam
            ? _$PersonPerFieldToJson.age(isGreaterThan as int)
            : notSetQueryParam,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.age(isGreaterThanOrEqualTo as int)
            : notSetQueryParam,
        isNull: isNull,
        whereIn: whereIn?.map((e) => _$PersonPerFieldToJson.age(e)),
        whereNotIn: whereNotIn?.map((e) => _$PersonPerFieldToJson.age(e)),
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery whereCount({
    Object? isEqualTo = notSetQueryParam,
    Object? isNotEqualTo = notSetQueryParam,
    Object? isLessThan = notSetQueryParam,
    Object? isLessThanOrEqualTo = notSetQueryParam,
    Object? isGreaterThan = notSetQueryParam,
    Object? isGreaterThanOrEqualTo = notSetQueryParam,
    bool? isNull,
    List<int>? whereIn,
    List<int>? whereNotIn,
  }) {
    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: $referenceWithoutCursor.where(
        _$PersonFieldMap['count']!,
        isEqualTo: isEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.count(isEqualTo as int)
            : notSetQueryParam,
        isNotEqualTo: isNotEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.count(isNotEqualTo as int)
            : notSetQueryParam,
        isLessThan: isLessThan != notSetQueryParam
            ? _$PersonPerFieldToJson.count(isLessThan as int)
            : notSetQueryParam,
        isLessThanOrEqualTo: isLessThanOrEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.count(isLessThanOrEqualTo as int)
            : notSetQueryParam,
        isGreaterThan: isGreaterThan != notSetQueryParam
            ? _$PersonPerFieldToJson.count(isGreaterThan as int)
            : notSetQueryParam,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo != notSetQueryParam
            ? _$PersonPerFieldToJson.count(isGreaterThanOrEqualTo as int)
            : notSetQueryParam,
        isNull: isNull,
        whereIn: whereIn?.map((e) => _$PersonPerFieldToJson.count(e)),
        whereNotIn: whereNotIn?.map((e) => _$PersonPerFieldToJson.count(e)),
      ),
      $queryCursor: $queryCursor,
    );
  }

  PersonQuery orderByDocumentId({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(FieldPath.documentId,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PersonQuery orderByName({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$PersonFieldMap['name']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PersonQuery orderBySex({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$PersonFieldMap['sex']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PersonQuery orderByAge({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$PersonFieldMap['age']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  PersonQuery orderByCount({
    bool descending = false,
    Object? startAt = _sentinel,
    Object? startAfter = _sentinel,
    Object? endAt = _sentinel,
    Object? endBefore = _sentinel,
    PersonDocumentSnapshot? startAtDocument,
    PersonDocumentSnapshot? endAtDocument,
    PersonDocumentSnapshot? endBeforeDocument,
    PersonDocumentSnapshot? startAfterDocument,
  }) {
    final query = $referenceWithoutCursor.orderBy(_$PersonFieldMap['count']!,
        descending: descending);
    var queryCursor = $queryCursor;

    if (startAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAt: const [],
        startAtDocumentSnapshot: startAtDocument.snapshot,
      );
    }
    if (startAfterDocument != null) {
      queryCursor = queryCursor.copyWith(
        startAfter: const [],
        startAfterDocumentSnapshot: startAfterDocument.snapshot,
      );
    }
    if (endAtDocument != null) {
      queryCursor = queryCursor.copyWith(
        endAt: const [],
        endAtDocumentSnapshot: endAtDocument.snapshot,
      );
    }
    if (endBeforeDocument != null) {
      queryCursor = queryCursor.copyWith(
        endBefore: const [],
        endBeforeDocumentSnapshot: endBeforeDocument.snapshot,
      );
    }

    if (startAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAt: [...queryCursor.startAt, startAt],
        startAtDocumentSnapshot: null,
      );
    }
    if (startAfter != _sentinel) {
      queryCursor = queryCursor.copyWith(
        startAfter: [...queryCursor.startAfter, startAfter],
        startAfterDocumentSnapshot: null,
      );
    }
    if (endAt != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endAt: [...queryCursor.endAt, endAt],
        endAtDocumentSnapshot: null,
      );
    }
    if (endBefore != _sentinel) {
      queryCursor = queryCursor.copyWith(
        endBefore: [...queryCursor.endBefore, endBefore],
        endBeforeDocumentSnapshot: null,
      );
    }

    return _$PersonQuery(
      _collection,
      $referenceWithoutCursor: query,
      $queryCursor: queryCursor,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _$PersonQuery &&
        other.runtimeType == runtimeType &&
        other.reference == reference;
  }

  @override
  int get hashCode => Object.hash(runtimeType, reference);
}

class PersonDocumentSnapshot extends FirestoreDocumentSnapshot<Person> {
  PersonDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final DocumentSnapshot<Person> snapshot;

  @override
  PersonDocumentReference get reference {
    return PersonDocumentReference(
      snapshot.reference,
    );
  }

  @override
  final Person? data;
}

class PersonQuerySnapshot
    extends FirestoreQuerySnapshot<Person, PersonQueryDocumentSnapshot> {
  PersonQuerySnapshot._(
    this.snapshot,
    this.docs,
    this.docChanges,
  );

  factory PersonQuerySnapshot._fromQuerySnapshot(
    QuerySnapshot<Person> snapshot,
  ) {
    final docs = snapshot.docs.map(PersonQueryDocumentSnapshot._).toList();

    final docChanges = snapshot.docChanges.map((change) {
      return _decodeDocumentChange(
        change,
        PersonDocumentSnapshot._,
      );
    }).toList();

    return PersonQuerySnapshot._(
      snapshot,
      docs,
      docChanges,
    );
  }

  static FirestoreDocumentChange<PersonDocumentSnapshot>
      _decodeDocumentChange<T>(
    DocumentChange<T> docChange,
    PersonDocumentSnapshot Function(DocumentSnapshot<T> doc) decodeDoc,
  ) {
    return FirestoreDocumentChange<PersonDocumentSnapshot>(
      type: docChange.type,
      oldIndex: docChange.oldIndex,
      newIndex: docChange.newIndex,
      doc: decodeDoc(docChange.doc),
    );
  }

  final QuerySnapshot<Person> snapshot;

  @override
  final List<PersonQueryDocumentSnapshot> docs;

  @override
  final List<FirestoreDocumentChange<PersonDocumentSnapshot>> docChanges;
}

class PersonQueryDocumentSnapshot extends FirestoreQueryDocumentSnapshot<Person>
    implements PersonDocumentSnapshot {
  PersonQueryDocumentSnapshot._(this.snapshot) : data = snapshot.data();

  @override
  final QueryDocumentSnapshot<Person> snapshot;

  @override
  final Person data;

  @override
  PersonDocumentReference get reference {
    return PersonDocumentReference(snapshot.reference);
  }
}

// **************************************************************************
// ValidatorGenerator
// **************************************************************************

void _$assertUser(User instance) {
  const EmailAddressValidator().validate(instance.email, 'email');
}

void _$assertPerson(Person instance) {
  const Min(0).validate(instance.age, 'age');
  const Max(30).validate(instance.count, 'count');
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      sex: json['sex'] as String?,
      age: json['age'] as int,
      email: json['email'] as String,
      count: json['count'] as int?,
    );

const _$UserFieldMap = <String, String>{
  'name': 'name',
  'sex': 'sex',
  'age': 'age',
  'count': 'count',
  'email': 'email',
};

// ignore: unused_element
abstract class _$UserPerFieldToJson {
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? sex(String? instance) => instance;
  // ignore: unused_element
  static Object? age(int instance) => instance;
  // ignore: unused_element
  static Object? count(int? instance) => instance;
  // ignore: unused_element
  static Object? email(String instance) => instance;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'sex': instance.sex,
      'age': instance.age,
      'count': instance.count,
      'email': instance.email,
    };

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String,
      sex: json['sex'] as String? ?? '',
      age: json['age'] as int,
      id: json['id'] as String,
      count: json['count'] as int? ?? 0,
    );

const _$PersonFieldMap = <String, String>{
  'id': 'id',
  'name': 'name',
  'sex': 'sex',
  'age': 'age',
  'count': 'count',
};

// ignore: unused_element
abstract class _$PersonPerFieldToJson {
  // ignore: unused_element
  static Object? id(String instance) => instance;
  // ignore: unused_element
  static Object? name(String instance) => instance;
  // ignore: unused_element
  static Object? sex(String? instance) => instance;
  // ignore: unused_element
  static Object? age(int instance) => instance;
  // ignore: unused_element
  static Object? count(int instance) => instance;
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sex': instance.sex,
      'age': instance.age,
      'count': instance.count,
    };
