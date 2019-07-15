def consolidate_cart(cart)
  new_cart = {}

  cart.each do |items_array| 
    items_array.each do |item, attribute_hash| 
      #will check if the statement on the left is true. If it is, it will continue to the next line of code. If the statement #is false or nil, it will set the statement on the left equal to the statement on the right.
        new_cart[item] ||= attribute_hash
        new_cart[item][:count] ? new_cart[item][:count] += 1 : new_cart[item][:count] = 1 
    end
  end
  new_cart
end

# def apply_coupons(cart, coupons)
#   coupons.each do |coupon| 
#     coupon.each do |attribute, value| 
#       #this will get inserted into AVOCADO W/ COUPONS
#       name = coupon[:item]
      
#       #if our cart includes the item in question, AND the number of these items in our cart is grater than or equal to the number of items required by our coupon, then execute the next line of code in our “if” statement
#       if cart[name] && cart[name][:count] >= coupon[:num] 
#         if cart["#{name} W/COUPON"] 
#           cart["#{name} W/COUPON"][:count] += 1 
#         else 
#           cart["#{name} W/COUPON"] = {
#             :price => coupon[:cost],
#             :clearance => cart[name][:clearance],
#             :count => 1
#           } 
#         end 
  
#       cart[name][:count] -= coupon[:num] 
#     end 
#   end 
# end 
#   cart 
# end

# def apply_clearance(cart)
#   # code here
# end

# def checkout(cart, coupons)
#   # code here
# end
