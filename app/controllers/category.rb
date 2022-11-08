class ApplicationController < Sinatra::Base
  
    get '/jipange-react-app/categories' do
        Category.all.to_json(include: :items)
    end
    
    get '/jipange-react-app/categories/:name' do
        category = Category.find_by(name: params[:name]).items.to_json(include: :category)
    end

    post '/jipange-react-app/categories' do
        category = Category.new(name: params[:name])
        if category.save
            category.to_json(include: :items)
        else
            {errors: category.errors_array}.to_json
        end
      end

     delete '/jipange-react-app/categories/:name' do
        category = Category.find_by(name: params[:name])
        if category
            category.destroy
            category.to_json(include: :items)
        else
            {errors: "Category not found"}.to_json
        end
    end
end