#!/bin/bash

export ARM_SUBSCRIPTION_ID=$(echo ${SUBSCRIPTION_ID//\"})
export ARM_TENANT_ID=$(echo ${TENANT_ID//\"})