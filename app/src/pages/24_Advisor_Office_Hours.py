import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Create New Office Hours Session")

with st.form("Create a New Office Hours Session"):
    start_time = st.text_input("Enter Session Start Time (DATETIME): ")
    end_time = st.text_input("Enter Session End Time (DATETIME): ")
    advisor_id = st.text_input("Enter Advisor ID: ")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {
        "session_startTime": start_time,
        "session_endTime": end_time,
        "advisor_id": advisor_id
    }
    response = requests.post(f"http://api:4000/e/events/", json=data)

    if response.status_code == 200:
        st.dataframe(response)
    else:
        st.write("Could not connect to the API, or not found.")
else:
    st.warning("Please press submit.")