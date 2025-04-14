import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks


SideBarLinks()

st.write("# Update Client Information")



client_id = st.text_input("Enter Client ID to change their recorded email:")
new_info = st.text_input("Enter New Client Email:")

if st.button("Update"):
    if client_id and new_info:

        data = {
            "client_email": new_info
        }
        response = requests.put(f"http://api:4000/a/client/{client_id}", json=data)
        if response.status_code == 200:
            response = "Client email updated successfully."
            st.write(response)
        else:
            st.write("Could not connect to the API, or project not found.")
    else:
        st.warning("Please enter all fields.")
