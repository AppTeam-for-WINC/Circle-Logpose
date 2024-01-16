# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
# Deploy with `firebase deploy`

# ここのmain.pyファイル内では、cloud functionsを登録するファイルである。

# https://cloud.google.com/functions/docs/securing/authenticating?authuser=4&hl=ja#functions-bearer-token-example-python
# https://pub.dev/packages/http
# https://pub.dev/packages/cloud_functions/example

# @https_fn.on_request()
# def on_request_example(req: https_fn.Request) -> https_fn.Response:
#     return https_fn.Response("Hello world!")

# @https_fn.on_request()
# def on_request_yeah(req: https_fn.Request) -> https_fn.Response:
#     return https_fn.Response("Yeahhhhhhhhh!")


# # cloud functions packageがある。
# @https_fn.on_call()
# def on_call_happy(id: https_fn.CallableRequest) -> str:
#     return 'happy halloween'


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


# @https_fn.on_request()
# def get_user_id_by_email_from_firestore(email: str) -> str or None:
#     db = firestore.client()

#     users_db = db.collection('users')
#     verify_result = users_db.where('email', '==', email).limit(1)
#     results = verify_result.stream()

#     for doc in results:
#         return doc.id
#     return None

# @firestore_fn.on_document_written(document="user/{userId}")
# def update_user_image(event: firestore_fn.Event[DocumentSnapshot], image: str) -> str or None:
#     #まだ途中
#     print('まだ途中')


# # chatgptを pythonで実行する。
    
# from langchain_openai import ChatOpenAI
# from langchain_core.prompts import ChatPromptTemplate

# # himitsu ki
# llm = ChatOpenAI(openai_api_key="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")
# llm.invoke("how can langsmith help with testing?")

# prompt = ChatPromptTemplate.from_messages([
#     ("system", "You are world class technical documentation writer."),
#     ("user", "{input}")
# ])
# chain = prompt | llm 
# chain.invoke({"input": "how can langsmith help with testing?"})


# このコードは正しく実行されます。
# from langchain.llms import OpenAI
# from langchain_openai import OpenAI

# from langchain_community.chat_models import ChatOpenAI

# def chat_gpt(question: str):
#     api_key: str ='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'
#     if api_key is None:
#         print("OpenAI API key is not set. Please set the OPENAI_API_KEY environment variable.")

#     # 実際は、gpt-3.5-turbo-0301が使用されている。また、2021年までのデータをもとにしている。
#     llm = ChatOpenAI(model_name="gpt-3.5-turbo", openai_api_key=api_key)

#     # 質問
#     output = llm.predict(question)

#     # 結果の出力
#     print(f"User: {question}")
#     print(f"AI: {output}")

# question = '2023年に起きた出来事を簡単に教えて'
# chat_gpt(question)




    

# import streamlit as st
# from streamlit_chat import message

# from langchain.chat_models import ChatOpenAI
# from langchain.memory import ConversationBufferMemory
# from langchain.chains import ConversationChain
# from langchain.schema import HumanMessage
# from langchain.schema import AIMessage

# from dotenv import load_dotenv
# # 環境変数の読み込み
# load_dotenv()

# # ChatGPT-3.5のモデルのインスタンスの作成
# chat = ChatOpenAI(model_name="gpt-3.5-turbo")

# # セッション内に保存されたチャット履歴のメモリの取得
# try:
#     memory = st.session_state["memory"]
# except:
#     memory = ConversationBufferMemory(return_messages=True)

# # チャット用のチェーンのインスタンスの作成
# chain = ConversationChain(
#     llm=chat,
#     memory=memory,
# )

# # Streamlitによって、タイトル部分のUIをの作成
# st.title("Chatbot in Streamlit")
# st.caption("by Masumi Morishige")

# # 入力フォームと送信ボタンのUIの作成
# text_input = st.text_input("Enter your message")
# send_button = st.button("Send")

# # チャット履歴（HumanMessageやAIMessageなど）を格納する配列の初期化
# history = []

# # ボタンが押された時、OpenAIのAPIを実行
# if send_button:
#     send_button = False

#     # ChatGPTの実行
#     chain(text_input)

#     # セッションへのチャット履歴の保存
#     st.session_state["memory"] = memory

#     # チャット履歴（HumanMessageやAIMessageなど）の読み込み
#     try:
#         history = memory.load_memory_variables({})["history"]
#     except Exception as e:
#         st.error(e)

# # チャット履歴の表示
# for index, chat_message in enumerate(reversed(history)):
#     if type(chat_message) == HumanMessage:
#         message(chat_message.content, is_user=True, key=2 * index)
#     elif type(chat_message) == AIMessage:
#         message(chat_message.content, is_user=False, key=2 * index + 1)