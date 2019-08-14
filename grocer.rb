def consolidate_cart(cart)
  new_cart = {}

  cart.each do |items_array| 
    items_array.each do |item, attribute_hash| 
      #will check if the statement on the left is true. If it is, it will continue to the next line of code. 
      # If the statement #is false or nil, it will set the statement on the left equal to the statement on the right.
        new_cart[item] ||= attribute_hash
        new_cart[item][:count] ? new_cart[item][:count] += 1 : new_cart[item][:count] = 1 
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include? coupon[:item]
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
  cart.each do |item, attribute_hash|
    if attribute_hash[:clearance] == true
      attribute_hash[:price] = (attribute_hash[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  cart_with_coupons_applied = apply_coupons(consolidated_cart, coupons)
  cart_with_discounts_applied = apply_clearance(cart_with_coupons_applied)

  total = 0.0
  cart_with_discounts_applied.keys.each do |item|
    total += cart_with_discounts_applied[item][:price] * cart_with_discounts_applied[item][:count]
  end
  
  total > 100.00 ? (total * 0.90).round : total
end
