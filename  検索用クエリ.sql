--　検索用クエリ

-- 課題１
SELECT エピソードタイトル, 視聴回数
FROM episodes
ORDER BY 視聴回数 DESC
LIMIT 3;

-- 課題2
SELECT program.タイトル, seasons.シーズン数, episodes.エピソード数, episodes.エピソードタイトル, episodes.視聴回数
FROM episodes
JOIN seasons ON episodes.シーズン_id = seasons.シーズン_id
JOIN program ON seasons.プログラム_id = program.プログラム_id
ORDER BY episodes.視聴回数 DESC
LIMIT 3;

-- 課題3
SELECT _channel.チャンネル名, _schedule.開始時間, _schedule.終了時間, seasons.シーズン数, episodes.エピソード数, episodes.エピソードタイトル, episodes.エピソード詳細
FROM _schedule
JOIN _channel ON _schedule.チャンネル_id = _channel.チャンネル_id
JOIN program ON _schedule.プログラム_id = program.プログラム_id
JOIN seasons ON _schedule.エピソード_id = seasons.シーズン_id
JOIN episodes ON seasons.シーズン_id = episodes.シーズン_id
WHERE DATE(_schedule.開始時間) = CURDATE();

-- 課題4
SELECT _channel.チャンネル名, _schedule.開始時間, _schedule.終了時間, seasons.シーズン数, episodes.エピソード数, episodes.エピソードタイトル, episodes.エピソード詳細
FROM _schedule
JOIN _channel ON _schedule.チャンネル_id = _channel.チャンネル_id
JOIN program ON _schedule.プログラム_id = program.プログラム_id
JOIN seasons ON _schedule.エピソード_id = seasons.シーズン_id
JOIN episodes ON seasons.シーズン_id = episodes.シーズン_id
WHERE _schedule.チャンネル_id = 1
AND _schedule.開始時間 BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 WEEK);

-- 課題5
SELECT program.タイトル, SUM(episodes.視聴回数) as 総視聴回数
FROM program
JOIN seasons ON program.プログラム_id = seasons.プログラム_id
JOIN episodes ON seasons.シーズン_id = episodes.シーズン_id
JOIN _schedule ON episodes.エピソード_id = _schedule.エピソード_id
WHERE _schedule.開始時間 BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 WEEK) AND CURDATE()
GROUP BY program.タイトル
ORDER BY 総視聴回数 DESC
LIMIT 2;

-- 課題6
SELECT program.ジャンル, program.タイトル, AVG(episodes.視聴回数) as 平均視聴数
FROM program
JOIN seasons ON program.プログラム_id = seasons.プログラム_id
JOIN episodes ON seasons.シーズン_id = episodes.シーズン_id
GROUP BY program.ジャンル, program.タイトル
ORDER BY 平均視聴数 DESC;