-- データベース作成
CREATE DATABASE internet_tv;

-- 以下テーブル設計

-- チャンネルテーブル
CREATE TABLE internet_tv._channel(
チャンネル_id INT NOT NULL auto_increment PRIMARY KEY,
チャンネル名 VARCHAR(100) NOT NULL,
ジャンル VARCHAR(100) NOT NULL
);

-- 番組テーブル
CREATE TABLE internet_tv.program(
プログラム_id INT NOT NULL auto_increment PRIMARY KEY,
タイトル VARCHAR(100) NOT NULL,
詳細 TEXT,
ジャンル VARCHAR(100) NOT NULL,
チャンネル_id INT NOT NULL,
UNIQUE KEY (タイトル, チャンネル_id),
FOREIGN KEY (チャンネル_id) REFERENCES channel(チャンネル_id)
);

-- シーズンテーブル
CREATE TABLE internet_tv.seasons(
シーズン_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
シーズン数 NOT NULL INT,
プログラム_id INT NOT NULL,
FOREIGN KEY (プログラム_id) references program (プログラム_id)
);

-- エピソードテーブル
CREATE TABLE internet_tv.episodes(
エピソード_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
エピソード数 INT,
エピソードタイトル VARCHAR(100) NOT NULL,
エピソード詳細 TEXT,
ビデオ時間 TIME NOT NULL,
公開日 DATE OT NULL,
視聴回数 INT NOT NULL,
シーズン_id INT NOT NULL,
FOREIGN KEY (シーズン_id) REFERENCES seasons (シーズン_id)
);

-- スケジュールテーブル
CREATE TABLE internet_tv._schedule(
スケジュール_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
開始時間 DATETIME NOT NULL,
終了時間 DATETIME NOT NULL,
チャンネル_id INT NOT NULL,
プログラム_id INT NOT NULL,
エピソード_id INT NOT NULL,
FOREIGN KEY (チャンネル_id) REFERENCES _channel (チャンネル_id),
FOREIGN KEY (プログラム_id) REFERENCES program (プログラム_id),
FOREIGN KEY (エピソード_id) REFERENCES episodes (エピソード_id)
);
