import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Create New Ideate Event")

with st.form("Create a New Ideate Event"):
    title = st.text_input("Enter Event Title: ")
    start_time = st.text_input("Enter Event Start Time: ")
    end_time = st.text_input("Enter Event End Time: ")
    num_rsvps = st.text_input("Enter Number of RVSPS: ")
    exec_id = st.text_input("Enter Executive ID: ")
    speaker_id = st.text_input("Enter Speaker ID: ")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {
        "event_title": title,
        "event_startTime": start_time,
        "event_endTime": end_time,
        "num_RSVPS": num_rsvps,
        "exec_id": exec_id,
        "speaker_id": speaker_id
    }
    response = requests.post("http://api:4000/e/events/", json=data)

    if response.status_code == 200:
        st.dataframe(response)
    else:
        st.write("Could not connect to the API, or not found.")
else:
    st.warning("Please press submit.")