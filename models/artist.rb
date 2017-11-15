require('pg')
require('pp')
require_relative('../db/sql_runner')
require_relative('album')
require_relative('artist')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end


  def save
    sql = "INSERT INTO artists (name) VALUES ($1)
          RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return result.map{|artist| Artist.new(artist)}
  end

  def all_albums
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map{|albums| Album.new(albums)}
  end

  def update
    sql = "UPDATE artists
           SET (name) = ($1)
           WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql,values)
  end

  def delete
    sql = "DELETE FROM artists WHERE id = $1"
    values =[@id]
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return result.map{|find| Artist.new(find)}
  end


end
