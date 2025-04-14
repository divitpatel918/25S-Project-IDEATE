import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Update Specific Event")

event_id = st.text_input("Enter Event ID that is being changed: ")
title = st.text_input("Enter New Event Title: ")
start_time = st.text_input("Enter New Start Time: ")
end_time = st.text_input("Enter New End Time: ")

if st.button("Change Event Attributes"):
    if event_id and title and start_time and end_time:
        data = {
            "event_id": event_id, 
            "event_title": title,
            "event_startTime": start_time,
            "event_endTime": end_time
        }
        response = requests.put(f"http://api:4000/e/events/{event_id}", json=data)
        if response.status_code == 200:
            response = "Event created successfully."
            st.write(response)
        else:
            st.write("Could not connect to the API, or not found.")
    else:
        st.write("Please enter a Event ID.")