// @ts-ignore
import JSEncrypt from './js-encrypt.js';
var AES = require('crypto-js/aes');
var ENC_UTF8 = require('crypto-js/enc-utf8');
var ENC_BASE64 = require('crypto-js/enc-base64');
var CTR_MODE = require('crypto-js/mode-ctr');
var PAD_NOPADDING = require('crypto-js/pad-nopadding');
function generateRandomBytes(byteLength) {
    var result = '';
    while (result.length < byteLength) {
        result += Math.random()
            .toString(36)
            .substr(2, 1);
    }
    return result;
}
function aesEncrypt(plaintext, keyString, ivString, mode, padding) {
    var key = ENC_UTF8.parse(keyString);
    var iv = ENC_UTF8.parse(ivString);
    var cipherResult = AES.encrypt(plaintext, key, {
        mode: mode,
        padding: padding,
        iv: iv
    });
    var ciphertext = cipherResult.ciphertext;
    var ciphertextBase64 = ciphertext.toString(ENC_BASE64);
    return ciphertextBase64;
}
function rsaEncrypt(plaintext, publicKey) {
    var en = new JSEncrypt();
    en.setPublicKey(publicKey);
    var cipher = en.encrypt(plaintext);
    return cipher;
}
/**
 * AES-128-CTR
 */
function ctrEncrypt(plaintext, keyString, ivString) {
    return aesEncrypt(plaintext, keyString, ivString, CTR_MODE, PAD_NOPADDING);
}
export function encryptByRSA(plaintext, publicKey) {
    var iv = generateRandomBytes(16);
    var aesKey = generateRandomBytes(16);
    var cipherText = ctrEncrypt(plaintext, aesKey, iv);
    var secretKey = rsaEncrypt(aesKey, publicKey);
    return {
        cipherText: cipherText,
        iv: iv,
        secretKey: secretKey
    };
}
