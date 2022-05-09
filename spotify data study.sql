-- Dataset from https://www.kaggle.com/datasets/muhmores/spotify-top-100-songs-of-20152019
-- rename table to 'spotify_top_songs'


-- Column descriptions:
-- title: song title
-- artist: song's artist
-- genre: genre of the song
-- year released: year the song was released
-- added: day song was added to Spotify's Top Hits playlist
-- bpm:	Beats Per Minute - The tempo of the song
-- nrgy: Energy - How energetic the song is
-- dnce: Danceability - How easy it is to dance to the song
-- dB: Decibel - How loud the song is
-- live: How likely the song is a live recording
-- val: How positive the mood of the song is
-- dur: Duration of the song
-- acous: How acoustic the song is
-- spch: The more the song is focused on spoken word
-- pop: Popularity of the song (not a ranking)
-- top year: Year the song was a top hit
-- artist type: Tells if artist is solo, duo, trio, or a band

-- The data is a set of all songs from spotify's top 100 playlist from 2010-2019 (100 songs from each year, over a 10 year period)



-- Ranking artist with most songs in the top 100's over the time period
SELECT
	artist, COUNT(artist) AS no_of_songs_in_top_100 
FROM 
	spotify.dbo.spotify_top_songs
GROUP BY
	artist
ORDER BY
	no_of_songs_in_top_100 DESC

-- Selecting most popular genre in the top 100's
SELECT
	top_genre, COUNT(top_genre) AS no_of_genre_in_top_100
FROM 
	spotify.dbo.spotify_top_songs
GROUP BY
	top_genre
ORDER BY
	no_of_genre_in_top_100 DESC

-- Selecting whether the top 100's are performed by solo singers or duo/band
SELECT
	artist_type, COUNT(artist_type) AS no_of_artist_types_in_top_100
FROM 
	spotify.dbo.spotify_top_songs
GROUP BY
	artist_type
ORDER BY
	no_of_artist_types_in_top_100 DESC

-- Analyzing trend over the years: Selecting the averages

SELECT 
	top_year,
	AVG(bpm) AS avg_bpm,
	AVG(nrgy) AS avg_nrgy,
	AVG(dnce) AS avg_dnce,
	AVG(db) AS avg_db,
	AVG(val) AS avg_val,
	AVG(dur) AS avg_dur
FROM
	spotify.dbo.spotify_top_songs
WHERE
	top_year IS NOT NULL
GROUP BY
	top_year
ORDER BY
	top_year 

-- Selecting the fastest and slowest songs among top 100 songs over the period, based on BPM
SELECT
	title,
	artist,
	top_genre,
	year_released,
	bpm,
	pop
FROM 
	spotify.dbo.spotify_top_songs
WHERE 
	bpm =(
	SELECT MAX(bpm)
	FROM spotify.dbo.spotify_top_songs)
	OR 
	bpm=(
	SELECT MIN(bpm)
	FROM spotify.dbo.spotify_top_songs)
ORDER BY 
	bpm DESC

-- Selecting the longest and shortest song (adding 'pop', might correlate with 'pop')
SELECT
	title,
	artist,
	top_genre,
	year_released,
	dur,
	pop
FROM 
	spotify.dbo.spotify_top_songs
WHERE 
	dur =(
	SELECT MAX(dur)
	FROM spotify.dbo.spotify_top_songs)
	OR 
	dur=(
	SELECT MIN(dur)
	FROM spotify.dbo.spotify_top_songs)
ORDER BY 
	dur DESC

-- Selecting song with lowest popularity index and respectively the lowest 
-- that ended up among top 100's over the time period.

SELECT 
	title,
	artist,
	top_genre,
	year_released,
	pop
FROM spotify.dbo.spotify_top_songs
WHERE pop =(
	SELECT MAX(pop)
	FROM spotify.dbo.spotify_top_songs)
	OR
	pop = (
	SELECT MIN(pop)
	FROM spotify.dbo.spotify_top_songs)



-- Has any k-pop song made it to the list over this time period?
-- Order by popularity index if there exists such songs.
SELECT 
	*
FROM 
	spotify.dbo.spotify_top_songs
WHERE 
	top_genre LIKE 'korean' OR
	top_genre LIKE 'k-pop' OR
	top_genre LIKE 'kpop'
ORDER BY
	pop DESC

