package com.ks.ksfinalb.service.user;

import com.ks.ksfinalb.dto.UserDto;
import com.ks.ksfinalb.model.User;
import com.ks.ksfinalb.request.CreateUserRequest;
import com.ks.ksfinalb.request.UserUpdateRequest;

public interface IUserService {

    User getUserById(Long userId);
    User createUser(CreateUserRequest request);
    User updateUser(UserUpdateRequest request, Long userId);
    void deleteUser(Long userId);

    UserDto convertUserToDto(User user);

    User getAuthenticatedUser();
}
