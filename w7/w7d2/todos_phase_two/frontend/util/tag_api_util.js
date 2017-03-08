export const fetchTagsUtil = () => {
  return $.ajax ({
    url: "api/tags",
    type: "GET",
    success: (response) => {
      // console.log(response);
      return response;
    }
  });
};


export const createTagUtil = (tag) => {
  console.log(tag);
  return $.ajax ({
    url: "api/tags",
    type: "POST",
    data: { tag },
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

export const deleteTagUtil = (tag) => {
  return $.ajax({
    url: `api/tags/${tag.id}`,
    type: "DELETE",
    success: (response) => {
      return response;
    },
    error: (err) => {
      return err.responseText;
    }
  });
};
