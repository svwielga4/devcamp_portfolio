class PortfoliosController < ApplicationController
    access all: [:show, :index, :angular, :ruby], user: {except: [:destroy, :new, :create, :update, :edit]}, site_admin: :all
    before_action :set_portfolio_item, only: [:edit, :update, :destroy, :show]
    layout "portfolio"
    def index
        @portfolio_items = Portfolio.all
    end

    def angular
        @angular_portfolio_items = Portfolio.angular
    end

    def ruby
        @ruby_on_rails_portfolio_items = Portfolio.ruby_on_rails
    end

    def new
        @portfolio_item = Portfolio.new
        3.times { @portfolio_item.technologies.build }
    end

    def create
        @portfolio_item = Portfolio.new(portfolio_params)
    
        respond_to do |format|
          if @portfolio_item.save
            format.html { redirect_to portfolios_path , notice: 'Your portfolio item is alive.' }
          else
            format.html { render :new }
          end
        end
    end

    def edit
    end

    def update
        respond_to do |format|
          if @portfolio_item.update(portfolio_params)
            format.html { redirect_to portfolios_path, notice: 'Portfolio was successfully updated.' }
            format.json { render :show, status: :ok, location: @blog }
          else
            format.html { render :edit }
            format.json { render json: @blog.errors, status: :unprocessable_entity }
          end
        end
    end

    def show 
    end

    def destroy
        #perform the lookup
            #taken care of in set_portfolio_item now

        #destroy the record
        @portfolio_item.destroy
        
        #redirect after destroy
        respond_to do |format|
          format.html { redirect_to portfolios_url, notice: 'Portfolio was destroyed and turned to dust.' }
          format.json { head :no_content }
        end
    end

    private
    def portfolio_params
        params.require(:portfolio).permit(:title, 
                                          :subtitle, 
                                          :body, 
                                          technologies_attributes: [:name] )
    end

    def set_portfolio_item
        @portfolio_item = Portfolio.find(params[:id])
    end
end
