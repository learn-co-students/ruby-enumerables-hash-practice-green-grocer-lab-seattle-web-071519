def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |item|
    if cart_hash[item.keys[0]]
      cart_hash[item.keys[0]][:count] += 1
    else
      cart_hash[item.keys[0]] = {
        :price => item.values[0][:price],
        :clearance => item.values[0][:clearance],
        :count => 1
      }
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    if cart.keys.include?(coupon[:item])
      if cart[coupon[:item]][:count] >= coupon[:num]
        new_name = "#{coupon[:item]} W/COUPON"
        if cart[new_name]
          cart[new_name][:count] += coupon[:num]
        else
          cart[new_name] = {
            count: coupon[:num],
            price: coupon[:cost]/coupon[:num],
            clearance: cart[coupon[:item]][:clearance]
          }
        end
      cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.keys.each do |item|
    if cart[item][:clearance]
      cart[item][:price] = (cart[item][:price]* 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here

  # consolidate cart for use in functions
  carty = consolidate_cart(cart)

  cart_n_coups = apply_coupons(carty, coupons)
  cart_n_sale = apply_clearance(carty)

  # total = 0.0
  # cart_n_sale.keys.each do |item|
  #   total += cart_n_sale[item][:price] * cart_n_sale[item][:count]
  # end

  # using reduce 

  cart_total = cart_n_sale.keys.reduce(0) do |total, item|
    total + cart_n_sale[item][:price] * cart_n_sale[item][:count]
  end

  # if total over $100, apply 10% discount
  cart_total > 100.00 ? (cart_total * 0.90).round : cart_total
end
