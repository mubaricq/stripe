class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])

    # Convert the price to cents
    unit_amount_cents = (product.price * 100).to_i

    @session = Stripe::Checkout::Session.create({
      mode: 'payment',
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd', # Change to 'eur' for Euro currency
          product_data: {
            name: product.name,
          },
          unit_amount: unit_amount_cents, # Use the converted price in cents
        },
        quantity: 1,
      }],
      success_url: root_url,
      cancel_url: root_url,
    })

    respond_to do |format|
      format.html # This tells Rails to respond with JavaScript
    end
  end
end
