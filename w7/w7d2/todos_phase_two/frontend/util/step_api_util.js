export const fetchStepsUtil = () => {
  return $.ajax ({
    url: "api/steps",
    type: "GET",
    success: (response) => {
      // console.log(response);
      return response;
    }
  });
};


export const createStepUtil = (step) => {
  console.log(step);
  return $.ajax ({
    url: "api/steps",
    type: "POST",
    data: { step },
    success: (response) => {
      // console.log(response);
      return response;
    },
    error: (err) => {
      // console.log(err.responseText);
      return err.responseText;
    }
  });
};

export const updateStepUtil = (step) => {
  return $.ajax ({
    url: `api/steps/${step.id}`,
    type: "PATCH",
    data: { step },
    success: (response) => {
      return response;
    },
    error: (err) => {
      // console.log(err.responseText);
      return err.responseText;
    }
  });
};

export const deleteStepUtil = (step) => {
  return $.ajax({
    url: `api/steps/${step.id}`,
    type: "DELETE",
    success: (response) => {
      return response;
    },
    error: (err) => {
      return err.responseText;
    }
  });
};
