require "sinatra"
require "sinatra/reloader"

get("/") do
  erb(:squaree)
end

get("/square/new") do
  erb(:squaree)
end

get("/square/results") do
  @the_num = params.fetch("number").to_f
  @the_result = (@the_num ** 2).round(4)
  erb(:square_res)
end

get("/square_root/new") do
  erb(:square_root)
end

get("/square_root/results") do
  @the_num = params.fetch("number").to_f
  if @the_num < 0
    @error_message = "The number cannot be negative"
    erb(:error)
  else
    @the_result = Math.sqrt(@the_num)
    erb(:squareroot_res)
  end
end

get("/payment/new") do
  erb(:paymentt)
end

get("/payment/results") do
  @apr = params.fetch("user_apr").to_f / 100
  @years = params.fetch("user_years").to_i
  @principal = params.fetch("user_pv").to_f
  if @apr <= 0 || @years <= 0 || @principal <= 0
    @error_message = "APR, years and principal must be greater than zero"
    erb(:error)
  else
    r = @apr / 12
    n = @years * 12
    numerator = r * @principal
    denominator = 1 - (1 + r)**-n
    @monthly_payment = (numerator / denominator).round(2)
    @apr = ActiveSupport::NumberHelper.number_to_percentage(@apr * 100, precision: 4)
    @principal = ActiveSupport::NumberHelper.number_to_currency(@principal)
    @monthly_payment = ActiveSupport::NumberHelper.number_to_currency(@monthly_payment)
    erb(:payment_res)
  end
end

get("/random/new") do
  erb(:random)
end

get("/random/results") do
  @min = params.fetch("user_min").to_f
  @max = params.fetch("user_max").to_f
  if @min >= @max
    @error_message = "Minimum value must be less than maximum value"
    erb(:error)
  else
    @random_number = rand(@min..@max)
    erb(:random_res)
  end
end
