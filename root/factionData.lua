tFactionValues = {
    {   
        name = "Vagabond"
        max = 2, -- how often can this faction be chosen?
        reach = {5, 2} -- whats the reach for each pick? Has to have 'max' amount of entries
        variants = {
            Thief = 1, --defines how often each individual role/variant can be picked
            Tinker = 1,
            Scoundrel = 1,
            Arbiter = 1,
            Ranger = 1,
            Vagrant = 1
        }
    },
    Marquise = {
        max = 1,
        reach = {10}
        variants = {
            main = 1,
        }
    },
    Eyrie = {
        max = 1,
        reach = {7}
        variants = {
            main = 1,
        }
    },
    Woodland = {
        max = 1,
        reach = {3}
        variants = {
            main = 1,
        }
    },
    Riverfolk = {
        max = 1,
        reach = {5}
        variants = {
            main = 1,
        }
    },
    Lizard = {
        max = 1,
        reach = {2}
        variants = {
            main = 1,
        }
    },
    Duchy = {
        max = 1,
        reach = {8}
        variants = {
            main = 1,
        }
    },
    Corvid = {
        max = 1,
        reach = {3}
        variants = {
            main = 1,
        }
    },
    Fangus = {
        max = 1,
        reach = {0}
        variants = {
            main = 1,
        }
    },
    Arachnid = {
        max = 1,
        reach = {0}
        variants = {
            main = 1,
        }
    },
    WeeklyCroak = {
        max = 1,
        reach = {0}
        variants = {
            main = 1,
        }
    },
    Boars = {
        max = 1,
        reach = {0}
        variants = {
            main = 1,
        }
    }
}


FactionData = { 
    name = "",
    max = 0,
    reach = {},
    variants = {}

    addVariant = function(self,name,max) --overwrites
        self.variants[v] = max
    end
}