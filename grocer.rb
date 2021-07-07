def consolidate_cart(cart)
   my_cart = {}
  
  cart.each_with_index do |item, i|
    item.each do |food, info|
      if my_cart[food]
        my_cart[food][:count] += 1
      else
        my_cart[food] = info
        my_cart[food][:count] = 1
      end
    end
  end
  my_cart
end

def apply_coupons(cart, coupons)
  my_cart = {}
  
  cart.each do |food, info|
    coupons.each do |coupon|
      if food == coupon[:item] && info[:count] >= coupon[:num]
        info[:count] =  info[:count] - coupon[:num]
        if my_cart["#{food} W/COUPON"]
          my_cart["#{food} W/COUPON"][:count] += 1
        else
          my_cart["#{food} W/COUPON"] = {:price => coupon[:cost], :clearance => info[:clearance], :count => 1}
        end
      end
    end
    my_cart[food] = info
  end
  my_cart
end

def apply_clearance(cart)
  cart.each do |item, attribute|
    if attribute[:clearance] == true
      attribute[:price] = (attribute[:price]*0.8).round(2)
    end
  end
  return cart
end

def checkout(cart, coupons)
 cart_cons = consolidate_cart(cart: cart)
  cart_coup = apply_coupons(cart:cart_cons, coupons:coupons)
  cart_check = apply_clearance(cart: cart_coup)
  total = 0
  cart_check.each do |item, attribute|
    total += attribute[:count] * attribute[:price]
  end
  return total = total > 100 ? (total*0.9).round(2) : total
end
}