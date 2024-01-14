# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

# ここのmain.pyファイル内では、cloud functionsを登録するファイルである。

# https://cloud.google.com/functions/docs/securing/authenticating?authuser=4&hl=ja#functions-bearer-token-example-python
# https://pub.dev/packages/http
# https://pub.dev/packages/cloud_functions/example

from firebase_functions import (
    firestore_fn, 
    https_fn
)
from firebase_functions.firestore_fn import (
  Event,
  Change,
  DocumentSnapshot,
)
from firebase_admin import initialize_app, firestore

initialize_app()


@https_fn.on_request()
def on_request_example(req: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Hello world!")

@https_fn.on_request()
def on_request_yeah(req: https_fn.Request) -> https_fn.Response:
    return https_fn.Response("Yeahhhhhhhhh!")


# cloud functions packageがある。
@https_fn.on_call()
def on_call_happy(id: https_fn.Request) -> https_fn.Response:
    return https_fn.Request("happy id")


# 既にauth_controlller.dartファイルにて機能していたので、不要。
# @firestore_fn.on_document_created(document="users/{userId}")
# def check_duplicate_user_email(event: firestore_fn.Event[DocumentSnapshot], userId: str) -> str or None:
#     new_user_data = event.data.to_dict()
#     user_email = new_user_data.get("email")
#     db = firestore.client()
#     users_ref = db.collection('users')
#     duplicate_result: bool = users_ref.where('email', '==', user_email).get()
#     if duplicate_result:
#         print('the email is already registerd.')
#         return 'The email address is already registerd.'
#     else:
#         print('no error.')
#         return None


@https_fn.on_request()
def get_user_id_by_email_from_firestore(email: str) -> str or None:
    db = firestore.client()

    users_db = db.collection('users')
    verify_result = users_db.where('email', '==', email).limit(1)
    results = verify_result.stream()

    for doc in results:
        return doc.id
    return None

@firestore_fn.on_document_written(document="user/{userId}")
def update_user_image(event: firestore_fn.Event[DocumentSnapshot], image: str) -> str or None:
    #まだ途中
    print('まだ途中')






# @firestore_fn.on_document_written(document="users/{userId}")
# def myfunction(event: Event[Change[firestore_fn.DocumentSnapshot]]) -> None:
#   # If we set `/users/marie` to {name: "Marie"} then
#   event.params["userId"] == "marie"  # True
#   # ... and ...
#   event.data.after.to_dict() == {"name": "Marie"}  # True


    




# @firestore_fn.on__created(document="users/{pushId}")
# def change_user_image(
#     event: firestore_fn.Event[firestore_fn.DocumentSnapshot | None], documentId: str,
# ) -> None:

#     # Get the value of "original" if it exists.
#     if event.data is None:
#         return
#     try:
#         original = event.data.get("images")
#     except KeyError:
#         # No "original" field, so do nothing.
#         return

#     # Set the "uppercase" field.
#     print(f"Uppercasing {event.params['pushId']}: {original}")
#     upper = original.upper()
#     event.data.reference.update({"uppercase": upper})





# @https_fn.on_request()
# def on_request_user_image(req: https_fn.Request) -> https_fn.Response:
#     original = req.args.get("text")
#     if original is None:
#         return https_fn.Response("No text parameter provided", status=400)

#     firestore_client: google.cloud.firestore.Client = firestore.client()

#     # Push the new message into Cloud Firestore using the Firebase Admin SDK.
#     _, doc_ref = firestore_client.collection("messages").add(
#         {"original": original}
#     )

#     # Send back a message that we've successfully written the message
#     return https_fn.Response(f"Message with ID {doc_ref.id} added.")


#     return https_fn.Response("")