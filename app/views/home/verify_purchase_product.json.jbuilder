if @list['kind'].nil?
  json.code = @list['error']['code']
  json.message = @list['error']['message']
else
  json.kind @list['kind']
  json.purchaseTimeMillis @list['purchaseTimeMillis']
  json.purchaseState @list['purchaseState']
  json.consumptionState @list['consumptionState']
  json.developerPayload @list['developerPayload']
end