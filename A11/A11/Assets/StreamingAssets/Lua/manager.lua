--manager:CreateSpaceShip("SpaceShip1", "seek", 0, 0, {max_velocity=12, max_force=12, max_speed=12, stop_distance=10}, {target="SpaceShip3"})
--manager:CreateSpaceShip("SpaceShip2", "flee", 5, 0, {max_velocity=10, max_force=10, max_speed=10, flee_distance=100}, {target="SpaceShip1"})
--manager:CreateSpaceShip("SpaceShip3", "wander", 10, 10, {max_velocity=10, max_force=10, max_speed=10, circle_distance=10, circle_radius=10, angle_change=0.2}, {})
--manager:CreateSpaceShip("SpaceShip4", "wander_flee", 10, 10, {max_velocity=10, max_force=10, max_speed=10, flee_distance=20, circle_distance=10, circle_radius=10, angle_change=0.2}, {target="SpaceShip3"})
--manager:CreateSpaceShip("SpaceShip5", "wander_seek", 10, 10, {max_velocity=10, max_force=10, max_speed=10, stop_distance=100, circle_distance=10, circle_radius=10, angle_change=0.2}, {target="SpaceShip3"})

--manager:CreateSpaceShip("SpaceShip1", "prey", 0, 0, {mass=10, max_velocity=12, max_force=12, max_speed=12, stop_distance=20, flee_distance=50, circle_distance=10, circle_radius=10, angle_change=0.2}, {target="SpaceShip2"})

--manager:CreateSpaceShip("SpaceShip2", "hunter", 10, 10, {mass=10, max_velocity=10, max_force=10, max_speed=10, stop_distance=10, flee_distance=50, circle_distance=10, circle_radius=10, angle_change=0.2}, {target="SpaceShip1"})

manager:CreateSpaceShip("SpaceShip1", "seek_mouse", 0, 0, {mass=10, max_velocity=12, max_force=12, max_speed=12, stop_distance=2}, {})
manager:CreateSpaceShip("Ship1", "seek", 0, 0, {mass=10, max_velocity=12, max_force=12, max_speed=12, stop_distance=10}, {target="SpaceShip1"})

manager:SetFollowCamera("SpaceShip1")
manager:SetCameraDistance(25)