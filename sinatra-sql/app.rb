require 'bundler'
Bundler.require

conn = PGconn.open(dbname: 'comics2')

get '/comics' do
	content_type :json
	res = conn.exec('SELECT id, title, publisher, year_of_release FROM series;')
	seriess = []
	res.each do |series|
		seriess.push(series)
	end
	seriess.to_json	
end

get '/comics/:id' do
	id = params[:id]
	res = conn.exec("SELECT id, title, publisher, year_of_release FROM series WHERE id = #{id};")
	comic = res[0]
	comic.to_json
end

post '/comics' do
	new_comic = JSON.parse(request.body.read)
	publisher = new_comic["publisher"]
	year_of_release = new_comic["year_of_release"]
	title = new_comic["title"]
	conn.exec("INSERT INTO series (title, publisher, year_of_release)
			VALUES ('#{title}', '#{publisher}', '#{year_of_release}');")
	"success"
end

patch '/comics/:id' do
	id = params[:id]
	updated_comic = JSON.parse(request.body.read)
	title = updated_comic["title"]
	publisher = updated_comic["publisher"]
	year_of_release = updated_comic["year_of_release"]
	conn.exec("UPDATE series SET title = '#{title}', publisher = '#{publisher}', year_of_release = '#{year_of_release}' WHERE id = #{id};")
	"success"
end

delete '/comics/:id' do 
	id = params["id"]
	conn.exec("DELETE FROM series WHERE id = #{id};")
	"success"
end

# get '/characters' do
# 	content_type :json
# 	res .conn.exec('SELECT id, title, ')













