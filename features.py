from datetime import datetime

from bs4 import BeautifulSoup
import math

"""
        This file will contain extra advance custom functions for better results.
"""


def html_parser_agent(html_value, feature="html.parser"):
    """
    This function will take html text and return plain text.
    :param html_value:
    :param feature:
    :return:
    """
    soup = BeautifulSoup(html_value, feature)
    return soup.text


def calculate_haversine_distance(user_lat, user_lng, restaurant_lat, restaurant_lng):
    """
    Function to calculate the distance manually.
    :param user_lat:
    :param user_lng:
    :param restaurant_lat:
    :param restaurant_lng:
    :return:
    """
    # Radius of the Earth in kilometers
    R = 6371.0

    lat1 = math.radians(user_lat)
    lon1 = math.radians(user_lng)
    lat2 = math.radians(restaurant_lat)
    lon2 = math.radians(restaurant_lng)

    dlon = lon2 - lon1
    dlat = lat2 - lat1

    a = math.sin(dlat / 2) ** 2 + math.cos(lat1) * math.cos(lat2) * math.sin(dlon / 2) ** 2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))

    distance = R * c  # Distance in kilometers

    return distance


def remove_duplicates(lst, key):
    """
    This  function will filter duplicate values from the list. Due to search functionality it is generating a list with
    repeated data. This function will take care of the duplicate values.
    :param lst:
    :param key:
    :return:
    """
    seen = set()
    result = []
    for item in lst:
        if item[key] not in seen:
            seen.add(item[key])
            result.append(item)
    return result


def file_rename(extension, name):
    """
    Function will return renamed file.
    :param extension:
    :param name:
    :return:
    """
    now = datetime.now()
    # Format the date as 'yyyyMMdd' (e.g., 20231010)
    timestamp = now.strftime('%Y%m%d_%H%M%S')

    return f"{name.replace('.', '_')}_{timestamp}.{extension}"


def dict_keys_to_list(dictionary):
    """
    Function will return list of keys in a dictionary.
    :param dictionary:
    :return:
    """
    key_list = list(dictionary.keys())
    return key_list


def concatenated_query(query):
    """
    This function will take a string as parameter and split with respect to spaces.
    Then join the separated words with + sign to make a space free query string.
    :param query:
    :return:
    """
    temp = list(query.split(" "))
    new_query = "+".join(temp)
    # print(new_query)
    return new_query


def get_unique_name_for_document(email):
    if "@" in email:
        first_part = email
        first_part = first_part.replace(".", "_")
        return first_part
    else:
        return None


def filter_duplicates_from_dict(data_list, key_name):
    seen_values = set()
    filtered_list = []

    for data in data_list:
        current_value = data.get(key_name)

        # Check if the value for the specified key is unique
        if current_value is not None and current_value not in seen_values:
            seen_values.add(current_value)
            filtered_list.append(data)
    return filtered_list


def sort_by_dict_keys(response, key):
    sorted_response = sorted(response, key=lambda x: x[key])
    return sorted_response


def get_minutes(deadline, checkin_time):
    """
    Function will return minutes difference between these two times.
    """
    # Convert string datetime to datetime objects
    deadline_dt = datetime.strptime(deadline, '%Y-%m-%d %H:%M:%S.%f')
    checkin_time_dt = datetime.strptime(checkin_time, '%Y-%m-%d %H:%M:%S.%f')

    # Calculate the time difference
    time_difference = deadline_dt - checkin_time_dt

    # Extract the minutes from the timedelta object
    minutes_difference = time_difference.total_seconds() / 60

    return int(minutes_difference)


def get_minutes_and_status(deadline, checkin_time):
    """
    This function will return time status as well. how much minutes is remaining and late or early status.
    """
    # Convert string datetime to datetime objects
    deadline_dt = datetime.strptime(deadline, '%Y-%m-%d %H:%M:%S.%f')
    checkin_time_dt = datetime.strptime(checkin_time, '%Y-%m-%d %H:%M:%S.%f')

    # Calculate the time difference
    time_difference = deadline_dt - checkin_time_dt

    # Extract the minutes from the timedelta object
    minutes_difference = int(time_difference.total_seconds() / 60)

    # Determine if check-in is late or on time
    if time_difference.total_seconds() > 0:
        status = f"{abs(minutes_difference)} minutes late"
    elif minutes_difference == 0:
        status = "On time"
    else:
        status = f"{abs(minutes_difference)} minutes remaining"

    return minutes_difference, status
