/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

//このファイルに firebase storageに関するコードを書く。また、index.tsがlib/index.jsファイルにコンパイルされて処理される。（詰まるところ、index.jsファイルに書いても実行されるというわけです。）

import {onRequest} from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = onRequest((request, response) => {
  logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});


export const testMorning = onRequest((request, response) => {
    logger.info("This is test. Good morning")
});