#!/bin/env ruby
# encoding: utf-8

require 'nokogiri'
require 'curb'

class FoodsController < ApplicationController
	# GET /foods/parser
  def parser
  	#Food.destroy_all	
		for i in 251..500 do
    	food = Food.new()
      html = Curl.get("http://www.pbd-online.sk/sk/menu/welcome/detail/?id=#{i}").body_str
      gem 'coffee-rails', '3.2.2'
      doc = Nokogiri.HTML(html, nil, 'utf-8')
     	
			doc.search('script').each do |nazov|
      	nazov = nazov.to_s
      	nazov = nazov.slice!(/h1.*h1/)
      	food.update_attributes!(:name => nazov[3..nazov.size-5])
    	end

    	doc.search('.datatable tr').each do |tr|
      	a = tr.search('td')
      	if "#{a.first.text.lstrip.chomp}" === 'Anglický názov potraviny'
         	food.update_attributes!(:englishName => a.last.text.lstrip.chomp)
      	end
      	if "#{a.first.text.lstrip.chomp}" === "VODA CELKOVÁ"
       	  food.update_attributes!(:water =>  a[2].text.lstrip.chomp)
     		end
				if "#{a.first.text.lstrip.chomp}" === "BIELKOVINY CELKOVÉ (HR. PROTEÍN)"
      	   food.update_attributes!(:proteins =>  a[2].text.lstrip.chomp)
     		end
				if "#{a.first.text.lstrip.chomp}" === "LIPIDY (TUKY) CELKOVÉ"
       	  food.update_attributes!(:fat =>  a[2].text.lstrip.chomp)
     		end
      	if"#{a.first.text.lstrip.chomp}" === "ENERGETICKÁ HODNOTA EÚ"
       	  food.update_attributes!(:energy =>  a[2].text.lstrip.chomp)
     		end
     		@foods = Food.all
  		end
		end
	end
				
  # GET /foods
  # GET /foods.json
  def index
    @foods = Food.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @foods }
    end
  end

  # GET /foods/1
  # GET /foods/1.json
  def show
    @food = Food.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @food }
    end
  end

  # GET /foods/new
  # GET /foods/new.json
  def new
    @food = Food.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @food }
    end
  end

  # GET /foods/1/edit
  def edit
    @food = Food.find(params[:id])
  end

  # POST /foods
  # POST /foods.json
  def create
    @food = Food.new(params[:food])

    respond_to do |format|
      if @food.save
        format.html { redirect_to @food, notice: 'Food was successfully created.' }
        format.json { render json: @food, status: :created, location: @food }
      else
        format.html { render action: "new" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /foods/1
  # PUT /foods/1.json
  def update
    @food = Food.find(params[:id])

    respond_to do |format|
      if @food.update_attributes(params[:food])
        format.html { redirect_to @food, notice: 'Food was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1
  # DELETE /foods/1.json
  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    respond_to do |format|
      format.html { redirect_to foods_url }
      format.json { head :no_content }
    end
  end
end
