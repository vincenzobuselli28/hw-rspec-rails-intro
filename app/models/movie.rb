require 'json'

class Movie < ActiveRecord::Base
    def self.all_ratings
      ['G', 'PG', 'PG-13', 'R']
    end
    
    def self.with_ratings(ratings, sort_by)
      if ratings.nil?
        all.order sort_by
      else
        where(rating: ratings.map(&:upcase)).order sort_by
      end
    end
  
    def self.find_in_tmdb(search_terms, key = "704c0c5042d0a6834b3e2686d2c11b5c")
      api_key = key
      title = search_terms[:title]
      language = search_terms[:language]
      release_date = search_terms[:release_year]
      
      if(language == nil)
        language = ""
      end
      if(release_date == nil)
        release_date = ""
      end
      
      main_url = 'https://api.themoviedb.org/3/search/movie?api_key='+api_key
      
      full_url = main_url+'&query='+title+'&language='+language+'&year='+release_date
      movies_temp = Faraday.get(full_url)
      
      if movies_temp != nil
        movies = JSON.parse(movies_temp.body)
      end
      
      return movies["results"]
    end
end
  