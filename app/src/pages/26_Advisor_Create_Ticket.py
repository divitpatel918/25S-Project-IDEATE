import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Create New Ticket")

with st.form("Create a New Ticket"):
    ticket_status = st.text_input("Enter Ticket Status: ")
    ticket_description = st.text_input("Enter Ticket Description: ")
    project_id = st.text_input("Enter Project ID: ")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {
        "ticket_status": ticket_status,
        "ticket_description": ticket_description,
        "project_id": project_id
    }
    response = requests.post(f"http://api:4000/a/ticket/", json=data)

    if response.status_code == 200:
        st.write("Created Ticket")
        st.dataframe(data)
    else:
        st.write("Could not connect to the API, or not found.")
else:
    st.warning("Please press submit.")