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

from langchain_community.chat_models import ChatOpenAI
import json
import os

initialize_app()
# firebase functions:secrets:set OPENAI_API_KEY
# firebase functions:secrets:access OPENAI_API_KEY
# OPENAI_API_KEY: 環境変数

@https_fn.on_request(secrets=["OPENAI_API_KEY"])
def chat_gpt(req: https_fn.Request) -> https_fn.Response:
    api_key = os.environ.get("OPENAI_API_KEY")
    result: dict = {}
    if api_key is None:
        return https_fn.Response("OpenAI API key is not current. Please set the OPENAI_API_KEY environment variable.")

    # 実際は、gpt-3.5-turbo-0301が使用されている。また、2021年までのデータをもとにしている。
    llm = ChatOpenAI(model_name="gpt-3.5-turbo", openai_api_key=api_key)

    # 質問
    question = req.get_json().get("question")

    # 結果
    answer = llm.predict(question)
    result = {"question": question, "answer": answer}

    return https_fn.Response(
        json.dumps(result),
        mimetype='application/json',
        status=200
    )
