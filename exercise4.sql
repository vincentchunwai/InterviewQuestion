CREATE TABLE PLAYERS(
	PLAYER_ID INTEGER NOT NULL UNIQUE,
	GROUP_ID INTEGER NOT NULL
)

CREATE TABLE MATCHES(
	MATCH_ID INTEGER NOT NULL UNIQUE,
	FIRST_PLAYER INTEGER NOT NULL,
	SECOND_PLAYER INTEGER NOT NULL,
	FIRST_SCORE INTEGER NOT NULL,
	SECOND_SCORE INTEGER NOT NULL
)


INSERT INTO PLAYERS VALUES (20, 2),
	(30, 1),
	(40, 3),
	(45, 1),
	(50, 2),
	(65, 1)

INSERT INTO MATCHES VALUES (1, 30, 45, 10, 12),
	(2, 20, 50, 5, 5),
	(13, 65, 45, 10, 10),
	(5, 30, 65, 3, 15),
	(42, 45, 65, 8, 4)
	
WITH FIRST_PLAYER_SCORE AS (
	SELECT FIRST_PLAYER AS ID, SUM(FIRST_SCORE) AS SCORE
	FROM MATCHES
	GROUP BY ID
), SECOND_PLAYER_SCORE AS(
	SELECT SECOND_PLAYER AS ID, SUM(SECOND_SCORE) AS SCORE
	FROM MATCHES
	GROUP BY ID
)
SELECT P.GROUP_ID, P.PLAYER_ID AS WINNER_ID, (F.SCORE+S.SCORE) AS SCORE
FROM PLAYERS P LEFT JOIN
FIRST_PLAYER_SCORE F ON P.PLAYER_ID = F.ID
LEFT JOIN SECOND_PLAYER_SCORE S ON P.PLAYER_ID = S.ID
ORDER BY (F.SCORE+S.SCORE), GROUP_ID
	
WITH WINNER AS (SELECT M.MATCH_ID, CASE WHEN
	FIRST_SCORE > SECOND_SCORE THEN FIRST_PLAYER
	WHEN SECOND_SCORE > FIRST_SCORE THEN SECOND_PLAYER
	WHEN FIRST_SCORE = SECOND_SCORE AND SECOND_PLAYER < FIRST_PLAYER THEN SECOND_PLAYER 
	WHEN FIRST_SCORE = SECOND_SCORE AND SECOND_PLAYER > FIRST_PLAYER THEN FIRST_PLAYER
	END AS WINNER_ID
    FROM MATCHES M
	ORDER BY MATCH_ID DESC)
, CTE AS(SELECT MAX(MATCH_ID) AS MATCH_ID, P.GROUP_ID AS GROUP_ID
			FROM PLAYERS P, WINNER W
			WHERE P.PLAYER_ID = W.WINNER_ID
			GROUP BY P.GROUP_ID),
   FINAL_WINNER AS(SELECT W.WINNER_ID AS WINNER_ID, C.GROUP_ID
		FROM WINNER W, CTE C
		WHERE C.MATCH_ID = W.MATCH_ID),

LEFTOVER AS(SELECT GROUP_ID, MIN(PLAYER_ID) AS PLAYER_ID
FROM PLAYERS
GROUP BY GROUP_ID)

SELECT W.GROUP_ID, L.PLAYER_ID
FROM LEFTOVER L LEFT JOIN FINAL_WINNER W
ON L.GROUP_ID = W.GROUP_ID







 

