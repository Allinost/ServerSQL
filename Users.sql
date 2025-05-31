-- 用户角色表
CREATE TABLE `user_roles` (
    `role_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色ID',
    `role_name` VARCHAR(50) NOT NULL UNIQUE COMMENT '角色名称 (e.g., admin)',
    `description` TEXT COMMENT '角色描述',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户角色表';

-- 用户表
CREATE TABLE `users` (
    `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    `username` VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    `password_hash` VARCHAR(255) NOT NULL COMMENT '密码哈希值',
    `email` VARCHAR(100) NOT NULL UNIQUE COMMENT '邮箱',
    `telephone` VARCHAR(16) NOT NULL UNIQUE COMMENT '电话号码',
    `full_name` VARCHAR(100) COMMENT '真实姓名',
    `role_id` INT UNSIGNED COMMENT '角色ID',
    `is_active` BOOLEAN DEFAULT TRUE COMMENT '是否激活',
    `last_login_at` TIMESTAMP NULL DEFAULT NULL COMMENT '最后登录时间',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`user_id`),
    INDEX `idx_username` (`username`),
    INDEX `idx_email` (`email`),
    INDEX `idx_telephone` (`telephone`),
    FOREIGN KEY (`role_id`) REFERENCES `user_roles`(`role_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 权限表 (可选, 用于更细粒度的权限控制)
CREATE TABLE `permissions` (
    `permission_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '权限ID',
    `permission_name` VARCHAR(100) NOT NULL UNIQUE COMMENT '权限名称',
    `description` TEXT COMMENT '权限描述',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限表';

-- 角色权限关联表 (可选, 多对多)
CREATE TABLE `role_permissions` (
    `role_id` INT UNSIGNED NOT NULL COMMENT '角色ID',
    `permission_id` INT UNSIGNED NOT NULL COMMENT '权限ID',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`role_id`, `permission_id`),
    FOREIGN KEY (`role_id`) REFERENCES `user_roles`(`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`permission_id`) REFERENCES `permissions`(`permission_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色权限关联表';