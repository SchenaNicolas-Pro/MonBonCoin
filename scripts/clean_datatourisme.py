#Best filter right now 14/11/2023

import json


def convert_to_list(item):
    if item is None:
        return []
    elif isinstance(item, list):
        return item
    else:
        return [item]

def convert_dict_values_to_lists(input_dict):
    for key, value in input_dict.items():
        if isinstance(value, dict):
            convert_dict_values_to_lists(value)
        elif isinstance(value, str):
            input_dict[key] = [value]

with open('before_cleaning.json', 'r') as json_file:
    data = json.load(json_file)

nouvelles_donnees = []

for objet in data['@graph']:
    nouvel_objet = {}
    
    if 'rdfs:comment' in objet:
        comment = objet['rdfs:comment']
        if isinstance(comment, list):
            for comment_item in comment:
                if '@value' in comment_item:
                    nouvel_objet.setdefault('rdfs:comment', []).append(comment_item['@value'])
        elif isinstance(comment, dict) and '@value' in comment:
            nouvel_objet['rdfs:comment'] = comment['@value']
    if 'rdfs:label' in objet:
        nouvel_objet['rdfs:label'] = objet['rdfs:label']['@value']
    if 'hasContact' in objet:
        contacts = objet['hasContact']
        if isinstance(contacts, list):
            for contact in contacts:
                contact_data = {}
                for key in ['schema:email', 'schema:telephone', 'foaf:homepage']:
                    if key in contact and contact[key]:
                        contact_data[key] = convert_to_list(contact[key])
                if contact_data:
                    nouvel_objet.setdefault('hasContact', []).append(contact_data)
        elif isinstance(contacts, dict):
            contact_data = {}
            for key in ['schema:email', 'schema:telephone', 'foaf:homepage']:
                if key in contacts and contacts[key]:
                    contact_data[key] = convert_to_list(contacts[key])
            if contact_data:
                nouvel_objet['hasContact'] = contact_data
    if 'hasRepresentation' in objet:
      representations = objet['hasRepresentation']
      if isinstance(representations, list):
          for rep_item in representations:
              if 'ebucore:hasRelatedResource' in rep_item:
                  related_resource = rep_item['ebucore:hasRelatedResource']
                  ebucore_locator = None  # Define ebucore_locator outside the if   block
                  if 'ebucore:locator' in related_resource:
                      locator = related_resource['ebucore:locator']
                      ebucore_locator = locator.get('@value')
                  if ebucore_locator:
                      nouvel_objet.setdefault('hasRepresentation', []).append({
                          'ebucore:locator': convert_to_list(ebucore_locator)
                      })
      elif isinstance(representations, dict):
          ebucore_locator = None  # Define ebucore_locator outside the if block
          if 'ebucore:hasRelatedResource' in representations:
              related_resource = representations['ebucore:hasRelatedResource']
              if 'ebucore:locator' in related_resource:
                  locator = related_resource['ebucore:locator']
                  ebucore_locator = locator.get('@value')
              if ebucore_locator:
                  nouvel_objet['hasRepresentation'] = {
                      'ebucore:locator': convert_to_list(ebucore_locator)
                  }
    if 'isLocatedAt' in objet:
        location = objet['isLocatedAt']
        if 'schema:address' in location:
            address = location['schema:address']
            nouvel_objet['isLocatedAt'] = {
                'schema:addressLocality': address.get('schema:addressLocality'),
                'schema:postalCode': address.get('schema:postalCode'),
                'schema:streetAddress': address.get('schema:streetAddress')
            }
        if 'schema:geo' in location:
            geo = location['schema:geo']
            nouvel_objet['isLocatedAt']['schema:latitude'] = geo.get('schema:latitude', {}).get('@value')
            nouvel_objet['isLocatedAt']['schema:longitude'] = geo.get('schema:longitude', {}).get('@value')
            
        if 'schema:openingHoursSpecification' in location:
            opening_hours = location['schema:openingHoursSpecification']
            if isinstance(opening_hours, list):
                for opening_hours_item in opening_hours:
                    opening_hours_data = {}
                    for key in ['schema:closes', 'schema:opens', 'schema:validFrom', 'schema:validThrough', 'additionalInformation']:
                        if key in opening_hours_item and opening_hours_item[key]:
                            if key == 'additionalInformation':
                                additional_information = opening_hours_item[key]
                                if isinstance(additional_information, list):
                                    values = [info.get('@value', '') for info in additional_information if '@value' in info]
                                    opening_hours_data[key] = values
                                else:
                                    values = additional_information.get('@value', '') if '@value' in additional_information else additional_information
                                    opening_hours_data[key] = values
                            else:
                                if isinstance(opening_hours_item[key], list):
                                    values = [info.get('@value', '') for info in opening_hours_item[key] if '@value' in info]
                                    opening_hours_data[key] = values
                                else:
                                    values = opening_hours_item[key].get('@value', '') if '@value' in opening_hours_item[key] else opening_hours_item[key]
                                    opening_hours_data[key] = values
                    if opening_hours_data:
                        nouvel_objet.setdefault('schema:openingHoursSpecification', []).append(opening_hours_data)
            elif isinstance(opening_hours, dict):
                opening_hours_data = {}
                for key in ['schema:closes', 'schema:opens', 'schema:validFrom', 'schema:validThrough', 'additionalInformation']:
                    if key in opening_hours and opening_hours[key]:
                        if key == 'additionalInformation':
                            additional_information = opening_hours[key]
                            if isinstance(additional_information, list):
                                values = [info.get('@value', '') for info in additional_information if '@value' in info]
                                opening_hours_data[key] = values
                            else:
                                values = additional_information.get('@value', '') if '@value' in additional_information else additional_information
                                opening_hours_data[key] = values
                        else:
                            if isinstance(opening_hours[key], list):
                                values = [info.get('@value', '') for info in opening_hours[key] if '@value' in info]
                                opening_hours_data[key] = values
                            else:
                                values = opening_hours[key].get('@value', '') if '@value' in opening_hours[key] else opening_hours[key]
                                opening_hours_data[key] = values
                if opening_hours_data:
                    nouvel_objet.setdefault('schema:openingHoursSpecification', []).append(opening_hours_data)





    if 'schema:offers' in objet:
        offers = objet['schema:offers']
        if isinstance(offers, dict):
            if 'schema:priceSpecification' in offers:
                price_specification = offers['schema:priceSpecification']
                if isinstance(price_specification, dict):
                    if 'schema:maxPrice' in price_specification:
                        max_price = price_specification['schema:maxPrice']
                        if isinstance(max_price, dict) and '@value' in max_price:
                            nouvel_objet['schema:maxPrice'] = max_price['@value']
                        elif isinstance(max_price, list):
                            max_prices = [price['@value'] for price in max_price]
                            nouvel_objet['schema:maxPrice'] = max_prices
                    if 'schema:minPrice' in price_specification:
                        min_price = price_specification['schema:minPrice']
                        if isinstance(min_price, list):
                            min_prices = [price['@value'] for price in min_price]
                            nouvel_objet['schema:minPrice'] = min_prices
                        elif isinstance(min_price, dict) and '@value' in min_price:
                            nouvel_objet['schema:minPrice'] = min_price['@value']
                    if 'schema:priceCurrency' in price_specification:
                        nouvel_objet['schema:priceCurrency'] = price_specification['schema:priceCurrency']
                    if 'appliesOnPeriod' in price_specification:
                        period = price_specification['appliesOnPeriod']
                        if isinstance(period, dict):
                            if 'startDate' in period:
                                nouvel_objet['startDate'] = period['startDate']['@value']
                            if 'endDate' in period:
                                nouvel_objet['endDate'] = period['endDate']['@value']

    
    fields_to_convert_to_list = ['rdfs:label', 'schema:email', 'schema:telephone', 'foaf:homepage', 'ebucore:locator']
    
    
    for field in fields_to_convert_to_list:
        if field in nouvel_objet:
            nouvel_objet[field] = convert_to_list(nouvel_objet[field])

    convert_dict_values_to_lists(nouvel_objet)
    
    fields_to_convert_to_list = ['schema:addressLocality', 'schema:postalCode', 'schema:streetAddress']
    
    for field in fields_to_convert_to_list:
        if field in nouvel_objet:
            nouvel_objet[field] = convert_to_list(nouvel_objet[field])
    
    fields_to_convert_to_list = ['schema:closes', 'schema:opens', 'schema:validFrom', 'schema:validThrough', 'additionalInformation']
    
    for field in fields_to_convert_to_list:
        if field in nouvel_objet:
            nouvel_objet[field] = convert_to_list(nouvel_objet[field])
            
    fields_to_convert_to_list = ['hasContact', 'hasRepresentation', 'schema:openingHoursSpecification']
    
    for field in fields_to_convert_to_list:
        if field in nouvel_objet:
            nouvel_objet[field] = convert_to_list(nouvel_objet[field])

    convert_dict_values_to_lists(nouvel_objet)

    nouvelles_donnees.append(nouvel_objet)

result_data = {'@graph': nouvelles_donnees}

with open('after_cleaning.json', 'w', encoding='utf-8') as new_json_file:
    json.dump(result_data, new_json_file, ensure_ascii=False, indent=4)
