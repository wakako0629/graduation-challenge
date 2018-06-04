class BlogsController < ApplicationController
  
    before_action :set_blog, only: [:show, :edit, :update, :destroy ]
    before_action :login_confirm, only: [:show, :edit, :new ,:update ,:destroy]
  
    def index
      @blogs = Blog.all
    end
    
    def new
      if params[:back]
        @blog = Blog.new(blog_params)
      else
        @blog = Blog.new
      end
    end
    

   def confirm
     @blog = Blog.new(blog_params)
     render :new if @blog.invalid?
   end

   def create
     @blog = Blog.new(blog_params)
     @blog.user_id = current_user.id
     # @blog.image.retrieve_from_cache! params[:cache][:image]
     @blog.save!
     if @blog.save
       redirect_to blogs_path, notice: "ブログを作成しました！"
       BlogMailer.blog_mail(@blog).deliver
     else
       render 'new'
     end
   end

 
   def edit
      
   end
  
   def update
       #@blog = Blog.find(params[:id])
     if @blog.update(blog_params)
       redirect_to blogs_path, notice: "ブログを編集しました！"
     else
       render 'edit'
     end
   end



   def destroy
     @blog.destroy
     redirect_to blogs_path, notice:"ブログを削除しました！"
   end
   

  
   private
      def blog_params
       params.require(:blog).permit(:title, :content, :image)
      end
  
      # idをキーとして値を取得するメソッド
      def set_blog
       @blog = Blog.find(params[:id])
      end
      
      def login_confirm
          redirect_to new_session_path unless !current_user.nil?
      end
      
         
    
end