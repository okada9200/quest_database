-- データ投入の手順
-- インターネットtvのデータベースを作成します。

-- 1　データベースを構築します

CREATE DATABASE internet_tv;

-- 2 テーブルを構築します。　
--　必要に応じてテーブル名、カラム名、データ型、キーなど追加します

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

-- 3 データを投入していきます。

--　サンプルデータは以下の通りです。

-- 番組テーブルのサンプルデータ
INSERT INTO program (プログラム_id, タイトル, 詳細, ジャンル, チャンネル_id) VALUES
(1, '鬼滅の刃', '鬼滅の刃の説明', 'アニメ', 2),
(2, 'テラスハウス', 'テラスハウスの説明', 'リアリティ', 1),
(3, 'サッカー中継', 'サッカー中継の説明', 'スポーツ', 3);

-- シーズンテーブルのサンプルデータ
INSERT INTO seasons (シーズン_id, シーズン数, プログラム_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3);

-- エピソードテーブルのサンプルデータ
INSERT INTO episodes (エピソード_id, エピソード数, エピソードタイトル, エピソード詳細 ,ビデオ時間, 公開日, 視聴回数, シーズン_id) VALUES
(1, 1, '第1話', '第1話の説明', '00:30:00', '2024-05-01', 1000, 1),
(2, 2, '第2話', '第2話の説明', '00:30:00', '2024-05-08', 1500, 1),
(3, 1, '第1話', '第1話の説明', '00:30:00', '2024-05-01', 1200, 2),
(4, 1, '試合開始', '試合開始の説明', '02:00:00', '2024-05-10', 2000, 3);

-- 番組スケジュールテーブルのサンプルデータ
INSERT INTO _schedule (スケジュール_id, 開始時間, 終了時間, チャンネル_id, プログラム_id, エピソード_id) VALUES
(1, '2024-05-01 10:00:00', '2024-05-01 10:30:00', 2, 1, 1),
(2, '2024-05-08 10:00:00', '2024-05-08 10:30:00', 2, 1, 2),
(3, '2024-05-01 20:00:00', '2024-05-01 21:00:00', 1, 2, 3),
(4, '2024-05-10 15:00:00', '2024-05-10 17:00:00', 3, 3, 4);
