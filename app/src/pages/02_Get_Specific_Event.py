import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Get Specific Event Info")
event_id = st.text_input("Enter Event ID: ")

if st.button("Access Info"):
    if event_id:
        response = requests.get(f"http://api:4000/e/events/{event_id}").json()
        if response.status_code == 200:
            st.dataframe(response)
        else:
            st.write("Could not connect to the API, or project not found.")
    else:
        st.warning("Please enter a Event ID.")